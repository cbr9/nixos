{
  pkgs,
  flakePath,
  nixosConfig,
  ...
}:
{
  # keep this for the future
  programs.helix.languages = {
    language-server = {
      pyright = {
        command = "pyright-langserver";
        args = [ "--stdio" ];
        config = { }; # <- this is the important line
      };
      # nil = {
      #   command = "nil";
      #   config = {
      #     formatting = {
      #       command = [ "nixfmt" ];
      #     };
      #     nix = {
      #       maxMemoryMB = 16000;
      #       flake = {
      #         autoArchive = true;
      #         autoEvalInputs = true;
      #       };

      #     };
      #   };
      # };
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
                expr = "${flake}.nixosConfigurations.${nixosConfig.networking.hostName}.options";
              };
              home-manager = {
                expr = "${flake}.nixosConfigurations.${nixosConfig.networking.hostName}.options.home-manager.users.type.getSubOptions []";
              };
            };
          };
      };
      rust-analyzer.config = {
        checkOnSave.command = "clippy";
        cachePriming.enable = true;
        diagnostics.experimental.enable = true;
        check.features = "all";
        procMacro.enable = true;
        cargo.buildScripts.enable = true;
        imports.preferPrelude = true;
        serverPath = "${pkgs.ra-multiplex}/bin/ra-multiplex";
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
