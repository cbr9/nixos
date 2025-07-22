{ ... }:
{
  # keep this for the future
  programs.helix.languages = rec {
    language-server = {
      pyright = {
        command = "pyright-langserver";
        args = [ "--stdio" ];
        config = { }; # <- this is the important line
      };
      nil = {
        command = "nil";
        config = {
          nix.flake = {
            autoArchive = true;
            autoEvalInputs = true;
          };
        };
      };
      rust-analyzer.config = {
        checkOnSave.command = "clippy";
        cachePriming.enable = false;
        diagnostics.experimental.enable = true;
        check.features = "all";
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
        formatter = formatter.nixfmt;
      }
    ];
  };
}
