{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    yazi.url = "github:sxyazi/yazi";
    helix.url = "github:helix-editor/helix";
    niri.url = "github:YaLTeR/niri";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, ... }@inputs:
    let
      mkLib = nixpkgs: nixpkgs.lib.extend (final: prev: (import ./lib final));
      lib = mkLib inputs.nixpkgs;

      # Helper to create NixOS configurations with common settings
      mkNixOSHost =
        {
          system,
          hostname,
          extraModules ? [ ],
        }:
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system lib;
            isLinux = true;
            isNixos = true;
            isDarwin = false;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.nix-index-database.nixosModules.nix-index
            ./modules/options.nix
            ./modules/home-manager
            (
              { modulesPath, ... }:
              {
                networking.hostName = hostname;
                imports = [
                  (modulesPath + "/installer/scan/not-detected.nix")
                  (modulesPath + "/profiles/qemu-guest.nix")
                  ./hosts/${hostname}
                ];
              }
            )
          ]
          ++ extraModules;
        };

      # Helper to create standalone home-manager configurations (non-NixOS Linux)
      mkHomeManagerHost =
        {
          system,
          hostname,
          extraModules ? [ ],
          extraSpecialArgs ? { },
        }:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit lib;
          pkgs = import ./modules/nix/mkPkgs.nix {
            inherit inputs system;
          };
          extraSpecialArgs = {
            inherit inputs system;
            isLinux = lib.isLinux system;
            isNixos = false;
            isDarwin = lib.isDarwin system;
            flakePath = "/home/cabero/Code/nixos";
            nixosConfig = null;
            darwinConfig = null;
          }
          // extraSpecialArgs;
          modules = [
            inputs.nix-index-database.homeModules.nix-index
            ./hosts/${hostname}
          ]
          ++ extraModules;
        };

      # Helper to create Darwin configurations with common settings
      mkDarwinHost =
        {
          system,
          hostname,
          extraModules ? [ ],
        }:
        inputs.nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = {
            inherit inputs system lib;
            isLinux = false;
            isNixos = false;
            isDarwin = true;
          };
          modules = [
            inputs.home-manager.darwinModules.home-manager
            ./modules/options.nix
            ./modules/home-manager
            ./hosts/${hostname}
          ]
          ++ extraModules;
        };

      # Supported systems for devShells
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = lib.genAttrs supportedSystems;
    in
    {
      nixosConfigurations = {
        naboo = mkNixOSHost {
          system = "x86_64-linux";
          hostname = "naboo";
        };
        endor = mkNixOSHost {
          system = "aarch64-linux";
          hostname = "endor";
        };
      };

      darwinConfigurations = {
        dagobah = mkDarwinHost {
          system = "aarch64-darwin";
          hostname = "dagobah";
        };
      };

      homeConfigurations = {
        machine-shop = mkHomeManagerHost {
          system = "x86_64-linux";
          hostname = "machine-shop";
        };
      };

      deploy.nodes.endor = {
        hostname = "endor";
        fastConnection = true;
        profiles.system = {
          user = "root";
          sshUser = "cabero";
          path = inputs.deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.endor;
        };
      };

      checks = forAllSystems (
        system:
        inputs.deploy-rs.lib.${system}.deployChecks self.deploy
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              git-crypt
              nixfmt-rfc-style
              nixd
              git-lfs
              git
              home-manager
              nix-prefetch-github
              just
              just-lsp
              inputs.deploy-rs.packages.${system}.deploy-rs
            ];
          };
        }
      );
    };
}
