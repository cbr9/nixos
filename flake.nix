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
  };

  outputs =
    { ... }@inputs:
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
          extraOverlays ? [ ],
          extraModules ? [ ],
          extraSpecialArgs ? { },
        }:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit lib;
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              (final: prev: {
                unstable = import inputs.nixpkgs-unstable {
                  inherit system;
                  config.allowUnfree = true;
                };
              })
            ]
            ++ extraOverlays;
          };
          extraSpecialArgs = {
            inherit inputs system;
            isLinux = lib.isLinux system;
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
      };

      darwinConfigurations = {
        dagobah = mkDarwinHost {
          system = "aarch64-darwin";
          hostname = "dagobah";
        };
      };

      homeConfigurations = {
        machine-shop-full = mkHomeManagerHost {
          system = "x86_64-linux";
          hostname = "machine-shop";
          extraSpecialArgs = {
          };
        };
      };

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
            ];
          };
        }
      );
    };
}
