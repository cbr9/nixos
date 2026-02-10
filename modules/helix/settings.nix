{
  ...
}:
{
  # stylix.targets.helix.enable = false;
  programs.helix.settings = {
    theme = "gruvbox";
    keys = {
      normal = {
        g = {
          l = [
            "select_mode"
            "goto_line_end"
            "normal_mode"
          ];
          h = [
            "select_mode"
            "goto_line_start"
            "normal_mode"
          ];
          g = [
            "select_mode"
            "goto_file_start"
            "normal_mode"
          ];
          G = [
            "select_mode"
            "goto_file_end"
            "normal_mode"
          ];
          e = [
            "select_mode"
            "goto_last_line"
            "normal_mode"
          ];
        };
      };
    };
    editor = {
      auto-completion = true;
      smart-tab.enable = false;
      line-number = "relative";
      true-color = true;
      cursorline = true;
      cursorcolumn = true;
      default-line-ending = "lf";
      rainbow-brackets = true;
      end-of-line-diagnostics = "hint";
      insert-final-newline = false;
      gutters = [
        "diff"
        "line-numbers"
        "spacer"
        "diagnostics"
      ];
      color-modes = true;
      bufferline = "always";
      completion-replace = false;

      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      file-picker = {
        hidden = true;
      };

      indent-guides = {
        render = true;
        # character = "⸽";
      };

      soft-wrap = {
        enable = true;
        wrap-at-text-width = false;
      };

      lsp = {
        display-inlay-hints = true;
        display-progress-messages = true;
      };

      statusline = {
        left = [
          "mode"
          "spinner"
          "read-only-indicator"
          "diagnostics"
        ];
        center = [ "file-name" ];
        right = [
          "version-control"
          "selections"
          "primary-selection-length"
          "total-line-numbers"
          "position"
          "file-encoding"
          "file-line-ending"
          "file-type"
        ];
        separator = "|";
        mode.normal = "NORMAL";
        mode.insert = "INSERT";
        mode.select = "SELECT";
      };

      whitespace = {
        render = {
          tab = "all";
        };
      };

      auto-save = {
        after-delay.enable = false;
        after-delay.timeout = 1000;
        focus-lost = true;
      };
    };
  };
}
