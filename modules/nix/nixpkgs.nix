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
      inputs.helix.overlays.default
      inputs.yazi.overlays.default
      (final: prev: {
        # organize = inputs.organize.defaultPackage.${system};
        stable = import inputs.nixpkgs-stable { inherit system config; };
        agenix = inputs.agenix.packages.x86_64-linux.default.override { ageBin = "${prev.age}/bin/age"; };

        google-chrome = (
          prev.google-chrome.override {
            commandLineArgs = [
              "--ozone-platform-hint=wayland"
            ];
          }
        );

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

        spotify = prev.spotify.overrideAttrs (oldAttrs: {
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
              substituteInPlace $out/share/applications/spotify.desktop \
                --replace "Exec=spotify" "Exec=spotify ${lib.concatStringsSep " " commandLineArgs}"
            '';
        });
      })
    ];
  };
}
