{ pkgs, config, lib, ... }:

let
  # Hardware IDs
  gpuIDs = [
    "1002:73bf" # RX 6900 XT
    "1002:ab28" # RX 6900 XT Audio
    "10de:1c82" # GTX 1050 Ti
    "10de:0fb9" # GTX 1050 Ti Audio
  ];
  
  # Helper to join IDs for virsh nodedev-detach
  virshGpuVideo = "pci_0000_08_00_0";
  virshGpuAudio = "pci_0000_08_00_1";

  startScript = pkgs.writeShellScript "qemu-hook-start" ''
    # Only run for win10 VM
    if [ "$1" != "win10" ] || [ "$2" != "prepare" ] || [ "$3" != "begin" ]; then
      exit 0
    fi

    # Stop Display Manager
    systemctl stop greetd
    
    # Unbind VTconsoles
    echo 0 > /sys/class/vtconsole/vtcon0/bind
    echo 0 > /sys/class/vtconsole/vtcon1/bind || true

    # Unbind EFI Framebuffer
    echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind || true

    # Wait for processes to release the GPU
    sleep 2

    # Unbind GPU from amdgpu
    echo "0000:08:00.0" > /sys/bus/pci/drivers/amdgpu/unbind
    echo "0000:08:00.1" > /sys/bus/pci/drivers/snd_hda_intel/unbind

    # Bind AMD to vfio-pci
    echo "vfio-pci" > /sys/bus/pci/devices/0000:08:00.0/driver_override
    echo "vfio-pci" > /sys/bus/pci/devices/0000:08:00.1/driver_override
    echo "0000:08:00.0" > /sys/bus/pci/drivers/vfio-pci/bind
    echo "0000:08:00.1" > /sys/bus/pci/drivers/vfio-pci/bind
    
    # Pre-set Nvidia to use 'nvidia' driver BEFORE unbinding from vfio-pci
    # This prevents vfio-pci from immediately re-grabbing it due to boot IDs
    echo "nvidia" > /sys/bus/pci/devices/0000:04:00.0/driver_override
    echo "snd_hda_intel" > /sys/bus/pci/devices/0000:04:00.1/driver_override

    # Unbind Nvidia from vfio-pci
    echo "0000:04:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
    echo "0000:04:00.1" > /sys/bus/pci/drivers/vfio-pci/unbind

    # Bind Nvidia to host drivers
    echo "0000:04:00.0" > /sys/bus/pci/drivers/nvidia/bind
    echo "0000:04:00.1" > /sys/bus/pci/drivers/snd_hda_intel/bind
    
    # Clear overrides
    echo "" > /sys/bus/pci/devices/0000:04:00.0/driver_override
    echo "" > /sys/bus/pci/devices/0000:04:00.1/driver_override

    # Restart Display Manager (should pick up 1050 Ti)
    systemctl start greetd
    
    # Wait for DM to initialize
    sleep 5
  '';

  stopScript = pkgs.writeShellScript "qemu-hook-stop" ''
    # Only run for win10 VM
    if [ "$1" != "win10" ] || [ "$2" != "release" ] || [ "$3" != "end" ]; then
      exit 0
    fi

    # Stop Display Manager
    systemctl stop greetd

    # Unbind AMD from vfio-pci
    echo "0000:08:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
    echo "0000:08:00.1" > /sys/bus/pci/drivers/vfio-pci/unbind

    # Bind AMD to amdgpu/snd_hda_intel
    echo "amdgpu" > /sys/bus/pci/devices/0000:08:00.0/driver_override
    echo "0000:08:00.0" > /sys/bus/pci/drivers/amdgpu/bind
    echo "" > /sys/bus/pci/devices/0000:08:00.0/driver_override
    
    echo "snd_hda_intel" > /sys/bus/pci/devices/0000:08:00.1/driver_override
    echo "0000:08:00.1" > /sys/bus/pci/drivers/snd_hda_intel/bind
    echo "" > /sys/bus/pci/devices/0000:08:00.1/driver_override

    # Pre-set Nvidia to use vfio-pci BEFORE unbinding from host drivers
    echo "vfio-pci" > /sys/bus/pci/devices/0000:04:00.0/driver_override
    echo "vfio-pci" > /sys/bus/pci/devices/0000:04:00.1/driver_override

    # Unbind Nvidia from host drivers
    echo "0000:04:00.0" > /sys/bus/pci/drivers/nvidia/unbind
    echo "0000:04:00.1" > /sys/bus/pci/drivers/snd_hda_intel/unbind

    # Bind Nvidia to vfio-pci
    echo "0000:04:00.0" > /sys/bus/pci/drivers/vfio-pci/bind
    echo "0000:04:00.1" > /sys/bus/pci/drivers/vfio-pci/bind
    
    # Keep override enabled so it stays with vfio-pci on next boot/scan
    # (actually we can clear it if the boot params handle it, but keeping it is safer)
    echo "vfio-pci" > /sys/bus/pci/devices/0000:04:00.0/driver_override
    echo "vfio-pci" > /sys/bus/pci/devices/0000:04:00.1/driver_override

    # Rebind EFI Framebuffer
    echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/bind || true

    # Rebind VTconsoles
    echo 1 > /sys/class/vtconsole/vtcon0/bind || true
    echo 1 > /sys/class/vtconsole/vtcon1/bind || true

    # Restart Display Manager (should pick up 6900 XT)
    systemctl start greetd
  '';

  hookParams = pkgs.writeShellScriptBin "qemu-hook" ''
    # Main hook dispatcher
    # Args: object operation sub-operation extra_args
    
    if [ "$2" = "prepare" ] && [ "$3" = "begin" ]; then
      ${startScript} "$@"
    elif [ "$2" = "release" ] && [ "$3" = "end" ]; then
      ${stopScript} "$@"
    fi
  '';

in {
  systemd.tmpfiles.rules = [
    "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu_kvm}/share/qemu/firmware"
    "z /dev/kvmfr0 0660 fantomtchi7 libvirtd -"
  ];

  # Boot parameters for IOMMU and VFIO isolation
  # IDs: 6900 XT (both), 1050 Ti (both)
  boot.kernelParams = [ 
    "amd_iommu=on" 
    "iommu=pt" 
    ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
  ];
  boot.kernelModules = [ "kvm-amd" "vfio-pci" "kvmfr" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # KVMFR (Looking Glass)
  boot.extraModulePackages = [ config.boot.kernelPackages.kvmfr ];
  boot.extraModprobeConfig = ''
    options kvmfr static_size_mb=128
  '';
  
  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", OWNER="fantomtchi7", GROUP="libvirtd", MODE="0660"
    KERNEL=="kvmfr0", SUBSYSTEM=="kvmfr", ACTION=="add", OWNER="fantomtchi7", GROUP="libvirtd", MODE="0660"
  '';
  
  services.udev.packages = [ config.boot.kernelPackages.kvmfr ];

  # Libvirt
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      verbatimConfig = ''
        namespaces = []
        security_driver = "none"
        cgroup_device_acl = [
          "/dev/null", "/dev/full", "/dev/zero",
          "/dev/random", "/dev/urandom",
          "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
          "/dev/rtc","/dev/hpet", "/dev/vfio/vfio",
          "/dev/kvmfr0"
        ]
      '';
    };
  };

  programs.virt-manager.enable = true;

  # Install hook
  system.activationScripts.libvirt-hooks.text = ''
    mkdir -p /var/lib/libvirt/hooks
    ln -sf ${hookParams}/bin/qemu-hook /var/lib/libvirt/hooks/qemu
  '';

  environment.systemPackages = with pkgs; [
    looking-glass-client
    virt-viewer
    spice-gtk
    virtio-win
    win-spice
  ];
  
  # Ensure user is in libvirtd group
  users.users.fantomtchi7.extraGroups = [ "libvirtd" "kvm" ];
}
