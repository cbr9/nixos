{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi.url = "github:sxyazi/yazi";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
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
      system = "x86_64-linux";
      mkLib = nixpkgs: nixpkgs.lib.extend (final: prev: (import ./lib final));
      lib = mkLib inputs.nixpkgs;
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations =
        with inputs;
        with builtins;
        {
          naboo = lib.nixosSystem rec {
            system = "x86_64-linux";
            specialArgs = { inherit inputs system; };

            modules = [
              nix-index-database.nixosModules.nix-index

              (
                { modulesPath, ... }:
                rec {
                  networking.hostName = "naboo";
                  imports = [
                    (modulesPath + "/installer/scan/not-detected.nix")
                    (modulesPath + "/profiles/qemu-guest.nix")
                    ./hosts/${networking.hostName}
                  ];
                }
              )

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "backup";
                home-manager.extraSpecialArgs = {
                  flakePath = "/data/cabero/Code/dotfiles";
                  inherit inputs;
                };
                home-manager.sharedModules = [
                  nix-index-database.homeModules.nix-index
                ];
              }
            ];
          };
          # work laptop
          dagobah = lib.nixosSystem rec {
            inherit lib;
            system = "x86_64-linux";
            specialArgs = { inherit inputs system; };

            modules = [
              nixos-wsl.nixosModules.default
              (
                { ... }:
                {
                  imports = [ ./hosts/dagobah ];
                }
              )
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "backup";
                home-manager.extraSpecialArgs = {
                  flakePath = "/home/cabero/Code/dotfiles";
                  inherit inputs;
                };
                home-manager.sharedModules = [
                  nix-index-database.homeModules.nix-index
                ];
              }
            ];
          };
        };

      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          git-crypt
          nixfmt-rfc-style
          nixd
          git-lfs
          git
          nix-prefetch-github
          just
        ];
      };
    };
}
