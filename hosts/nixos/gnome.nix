{ pkgs, ... }:
{
  services.xserver = {
    displayManager.gdm = {
      enable = true;
      debug = true;
      autoSuspend = false;
    };
    desktopManager.gnome = {
      enable = true;
      debug = true;
      extraGSettingsOverridePackages = [ pkgs.unstable.mutter ];
    };
  };
}
