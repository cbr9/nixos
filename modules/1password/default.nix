{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs._1password;
in
{
  nixpkgs.overlays = [
    (final: prev: {
      # organize = inputs.organize.defaultPackage.${system};
      _1password-gui = prev._1password-gui.overrideAttrs (oldAttrs: {
        postInstall =
          let
            commandLineArgs = [
              "--ozone-platform=wayland"
              "--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer,WaylandWindowDecorations"
              "--enable-wayland-ime=true"
            ];
          in
          (oldAttrs.postInstall or "")
          + ''
            substituteInPlace $out/share/applications/1password.desktop \
              --replace "Exec=1password" "Exec=1password ${lib.concatStringsSep " " commandLineArgs}"
          '';
      });
    })
  ];

  programs = {
    _1password.enable = true;
    _1password-gui = {
      package = pkgs._1password-gui;
      enable = cfg.enable;
      polkitPolicyOwners = [ "cabero" ];
    };
  };
}
