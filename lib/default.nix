lib:
let
  stateVersion = "25.05";
in
{
  indexOf =
    element: list:
    let
      helper =
        list: index:
        if list == [ ] then
          null
        else if builtins.head list == element then
          index
        else
          helper (lib.lists.drop 1 list) (index + 1);
    in
    helper list 0;

  # sorts a list of attribute sets by comparing a field in each of the attrsets, with a user-defined order
  sortAttrsList =
    path: list: order:
    builtins.sort (
      a: b:
      (lib.indexOf (lib.attrsets.getAttrFromPath path a) order)
      < (lib.indexOf (lib.attrsets.getAttrFromPath path b) order)
    ) list;

  boolToString = bool: if bool == true then "true" else "false";

  mkHosts =
    hosts: system: inputs:
    lib.genAttrs hosts (
      host:
      lib.mkHost {
        inherit inputs system;
        hostName = host;
      }
    );

  mkHost =
    {
      inputs,
      hostName,
      system ? "x86_64-linux",
    }:
    with inputs;
    with builtins;
    lib.nixosSystem {
      inherit system lib;
      specialArgs = { inherit inputs system; };

      modules = [
        # disko.nixosModules.disko
        agenix.nixosModules.default
        # stylix.nixosModules.stylix
        nur.modules.nixos.default

        (
          {
            modulesPath,
            pkgs,
            ...
          }:
          {
            imports = [
              (modulesPath + "/installer/scan/not-detected.nix")
              (modulesPath + "/profiles/qemu-guest.nix")
              ../hosts/${hostName}
              ../users
              ../modules/nixos
            ];

            config = {
              boot.kernelPackages = pkgs.linuxPackages_latest;
              boot.kernelModules = [ "i2c-dev" ];
              system.stateVersion = stateVersion;
              documentation.man.generateCaches = true;
              powerManagement.enable = true;

              environment = {
                pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
              };

              hardware = {
                i2c.enable = true;
                sane.enable = true;
              };

              networking = {
                inherit hostName;
                # iproute2.enable = true;
                enableIPv6 = true;
                dhcpcd.enable = true;
              };

              services = {
                upower.enable = true;
                # Enable CUPS to print documents.
                printing = {
                  enable = true;
                  drivers = [ pkgs.cnijfilter2 ];
                  cups-pdf.enable = false;
                  startWhenNeeded = true;
                  browsing = true;
                  browsedConf = ''
                    BrowseDNSSDSubTypes _cups,_print
                    BrowseLocalProtocols all
                    BrowseRemoteProtocols all
                    CreateIPPPrinterQueues All
                    BrowseProtocols all
                  '';
                };
                avahi = {
                  enable = true;
                  nssmdns4 = true;
                  openFirewall = true;
                };
              };
            };
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
}
