{ pkgs, ... }:
{
  environment.systemPackages = [
    # Need pulseaudio cli tools for pipewire.
    pkgs.pulseaudio
  ];

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
