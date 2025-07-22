{ ... }:
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
      line-number = "relative";
      true-color = true;
      auto-save = true;
      cursorline = true;
      cursorcolumn = true;
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
        character = "⸽";
      };

      soft-wrap = {
        enable = true;
        wrap-at-text-width = false;
      };

      lsp = {
        display-messages = true;
        display-inlay-hints = true;
        auto-signature-help = true;
      };

      statusline = {
        left = [
          "mode"
          "spinner"
        ];
        center = [ "file-name" ];
        right = [
          "total-line-numbers"
          "diagnostics"
          "selections"
          "position"
          "file-encoding"
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
    };
  };
}
