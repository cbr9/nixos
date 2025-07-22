{ pkgs, ... }:
{
  networking.firewall = {
    allowedUDPPorts = [ 5353 ];
    allowedTCPPorts = [ 57621 ];
  };

  age.secrets.spotify.file = ../../../secrets/spotify.age;

  home-manager.users.cabero = {
    services.spotifyd = {
      enable = true;
      package = pkgs.spotifyd;
      settings = {
        global = {
          username = "31vtbbqkijxmfhlidy4clznrf6a4";
          password_cmd = "sudo cat /run/agenix/spotify";
          device_type = "computer";
          device_name = "spotifyd";
          backend = "pulseaudio";
          bitrate = 320;
        };
      };
    };

    home.packages = [ pkgs.spotify ];
  };
}
