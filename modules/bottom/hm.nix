{ pkgs, ... }:
{
  programs.bottom = {
    enable = true;
    package = pkgs.unstable.bottom;
    settings = {
      flags = {
        color = "gruvbox";
        mem_as_value = true;
        enable_gpu_memory = true;
      };
    };
  };
}
