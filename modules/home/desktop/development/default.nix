{ pkgs, ... }:
{
  home.packages = with pkgs; [
    typescript
    postgresql
    docker
    docker-compose
    nodejs
    prisma
    prisma-engines
    dotnet-sdk_9
    dotnet-runtime_9
    dotnet-aspnetcore_9
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-dotnettools.vscodeintellicode-csharp
      ms-dotnettools.vscode-dotnet-runtime
      ms-dotnettools.csharp
      ms-dotnettools.csdevkit
      ms-python.vscode-pylance
      ms-python.python
      ms-python.pylint
      prisma.prisma

      christian-kohler.path-intellisense
      christian-kohler.npm-intellisense
      jnoortheen.nix-ide
    ];
  };

  home.sessionVariables = {
    EDITOR = "codium --wait";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
    PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
    PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
    PRISMA_FMT_BINARY = "${pkgs.prisma-engines}/bin/prisma-fmt";
    DOTNET_ROOT = "${pkgs.dotnet-sdk_9}/share/dotnet";
  };
}