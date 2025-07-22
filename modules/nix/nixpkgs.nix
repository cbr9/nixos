{
  inputs,
  lib,
  system,
  ...
}: let
  config = {
    allowUnfree = true;
  };
in {
  nixpkgs.pkgs = import inputs.nixpkgs {
    inherit system config;
    overlays = [
      (final: prev: {
        # organize = inputs.organize.defaultPackage.${system};
        unstable = import inputs.nixpkgs-unstable {inherit system config;};
        agenix = inputs.agenix.packages.x86_64-linux.default.override {ageBin = "${prev.age}/bin/age";};

        google-chrome = (
          prev.google-chrome.override {
            commandLineArgs = [
              "--ozone-platform-hint=wayland"
            ];
          }
        );

        # _1password-gui = prev._1password-gui.overrideAttrs (oldAttrs: {
        #   # This 'postInstall' hook modifies the desktop file after installation
        #   postInstall =
        #     let
        #       commandLineArgs = [
        #         "--ozone-platform=wayland"
        #         "--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer,WaylandWindowDecorations"
        #         "--enable-wayland-ime=true"
        #       ];
        #     in
        #     (oldAttrs.postInstall or "")
        #     + ''
        #       substituteInPlace $out/share/applications/1password.desktop \
        #         --replace "Exec=1password" "Exec=1password ${lib.concatStringsSep " " commandLineArgs}"
        #     '';
        # });
        # spotify = (
        #   prev.spotify.override {
        #     commandLineArgs = [
        #       "--force-device-scale-factor=1.25"
        #       "--enable-features=UseOzonePlatform"
        #       "--ozone-platform-hint=wayland"
        #     ];
        #   }
        # );
      })
    ];
  };
}
