{ pkgs, ... }:
{
  programs.yazi.settings = {
    plugin = {
      prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };
    opener = {
      edit = [
        {
          run = "${pkgs.helix}/bin/hx $@";
          block = true;
          desc = "Helix";
        }
      ];
      play = [
        {
          run = "${pkgs.vlc}/bin/vlc $@";
          orphan = true;
          desc = "VLC";
        }
      ];
    };

    open = {
      prepend_rules = [
        {
          mime = "text/*";
          use = "edit";
        }
        {
          mime = "application/json";
          use = "edit";
        }

        # Multiple editers for a single rule
        {
          name = "*.html";
          use = [
            "browser"
            "edit"
          ];
        }

        {
          mime = "video/*";
          use = "media";
        }
        {
          mime = "audio/*";
          use = [
            "audio"
            "media"
          ];
        }
        {
          mime = "application/json";
          use = "edit";
        }
        {
          name = "*.toml";
          use = "edit";
        }
        {
          name = "*.xml";
          use = "edit";
        }
        {
          name = "*.txt";
          use = "edit";
        }
        {
          name = "*.nu";
          use = "edit";
        }
      ];
      append_rules = [
        {
          mime = "video/*";
          use = "media";
        }
        {
          mime = "audio/*";
          use = "media";
        }
      ];
    };
  };
}
