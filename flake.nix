{
  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    impermanence.url = "github:nix-community/impermanence";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
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
              agenix.nixosModules.default
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
                home-manager.extraSpecialArgs = { inherit inputs; };
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
                home-manager.extraSpecialArgs = { inherit inputs; };
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
