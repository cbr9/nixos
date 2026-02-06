{ ... }:
{
  programs.starship = {
    enable = true;
    enableTransience = true;
    enableBashIntegration = false;
    settings = {
      hostname.ssh_only = false;
      shell.disabled = false;
      time.disabled = false;
    };
  };
}
