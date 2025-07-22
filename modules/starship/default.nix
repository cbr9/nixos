{ ... }:
{
  home-manager.users.cabero = {
    programs.starship = {
      enable = true;
      enableTransience = false;
      enableBashIntegration = false;
      settings = {
        hostname.ssh_only = false;
        shell.disabled = false;
        time.disabled = false;
      };
    };
  };
}
