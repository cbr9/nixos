{...}: {
  home-manager.users.cabero = {
    programs.zoxide = {
      enable = true;
      options = [
        "--hook pwd"
      ];
    };
  };
}
