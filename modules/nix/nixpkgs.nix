{
  inputs,
  lib,
  system,
  ...
}:
let
  config = {
    allowUnfree = true;
  };
in
{
  nixpkgs.pkgs = import inputs.nixpkgs {
    inherit system config;
    overlays = [
      inputs.yazi.overlays.default
      inputs.niri.overlays.default
      (final: prev: {
        # organize = inputs.organize.defaultPackage.${system};
        unstable = import inputs.nixpkgs-unstable {
          inherit system config;
          overlays = [
            (final: prev: {
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
        };
        agenix = inputs.agenix.packages.x86_64-linux.default.override { ageBin = "${prev.age}/bin/age"; };
      })
    ];
  };
}
