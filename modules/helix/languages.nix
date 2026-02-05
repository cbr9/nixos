{
  pkgs,
  flakePath,
  nixosConfig ? null,
  darwinConfig ? null,
  isLinux ? false,
  ...
}:
let
  hostname =
    if nixosConfig != null then
      nixosConfig.networking.hostName
    else if darwinConfig != null then
      darwinConfig.networking.hostName
    else
      "unknown";
  configType = if isLinux then "nixosConfigurations" else "darwinConfigurations";
in
{
  # keep this for the future
  programs.helix.languages = {
    language-server = {
      pyright = {
        command = "pyright-langserver";
        args = [ "--stdio" ];
        config = { }; # <- this is the important line
      };
      nixd = {
        command = "nixd";
        args = [ ];
        config.nixd =
          let
            flake = "(builtins.getFlake \"${flakePath}\")";
          in
          {
            nixpkgs = {
              expr = "import ${flake}.inputs.nixpkgs { }";
            };
            formatting = {
              command = [ "nixfmt" ];
            };
            options = {
              nixos = {
                expr = "${flake}.${configType}.${hostname}.options";
              };
              home-manager = {
                expr = "${flake}.${configType}.${hostname}.options.home-manager.users.type.getSubOptions []";
              };
            };
          };
      };
      rust-analyzer.config = {
        checkOnSave = true;
        cachePriming.enable = true;
        diagnostics.experimental.enable = true;
        check.features = "all";
        procMacro.enable = true;
        cargo.buildScripts.enable = true;
        imports.preferPrelude = true;
        serverPath = "${pkgs.lspmux}/bin/lspmux";
      };
    };

    formatter = {
      black = {
        command = "black";
        args = [
          "-"
          "-q"
        ];
      };
      nixfmt = {
        command = "nixfmt";
      };
    };

    language = [
      {
        name = "nix";
        scope = "source.nix";
        auto-format = true;
        # formatter = formatter.nixfmt;
      }
    ];
  };
}
