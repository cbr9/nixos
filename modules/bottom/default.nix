{...}: {
  home-manager.users.cabero = {
    programs.bottom = {
      enable = true;
      settings = {
        flags = {
          color = "gruvbox";
          mem_as_value = true;
          enable_gpu_memory = true;
        };
      };
    };
  };
}
