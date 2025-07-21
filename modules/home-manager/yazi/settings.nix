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
        {
          id = "mime";
          name = "*";
          run = "mime-ext";
          prio = "high";
        }
      ];
    };
    opener = {
      edit = [
        {
          run = "${pkgs.helix}/bin/hx \"$@\"";
          block = true;
          desc = "Helix";
        }
      ];
      play = [
        {
          run = "${pkgs.vlc}/bin/vlc \"$@\"";
          orphan = true;
          desc = "VLC";
        }
      ];
      ouch_no = [
        {
          run = "${pkgs.ouch}/bin/ouch d --no \"$@\"";
          orphan = true;
          desc = "Decompress without overwriting";
        }
      ];
      ouch_yes = [
        {
          run = "${pkgs.ouch}/bin/ouch d --yes \"$@\"";
          orphan = true;
          desc = "Decompress and overwrite";
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
          mime = "application/x-subrip";
          use = "edit";
        }
        {
          name = "*.zip";
          use = [
            "ouch_no"
            "ouch_yes"
          ];
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
