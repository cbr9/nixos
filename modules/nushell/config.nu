let zoxide = {|spans|
    $spans | skip 1 | zoxide query --score --list ...$in | detect columns --no-headers | rename score path | into float score | sort-by score | reverse | get path
}

let fish = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}

let completer = {|spans|

  let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
      __zoxide_z | __zoxide_zi => $zoxide
      _ => $fish
    } | do $in $spans
}

$env.config = {
  show_banner: false,
  hooks: {
          pre_prompt: [{ null }] # run before the prompt is shown
          pre_execution: [{ null }] # run before the repl input is run
          env_change: {
              PWD: [{|before, after| zoxide add $after }] # run if the PWD environment is different since the last repl input
          }
          display_output: "if (term size).columns >= 100 { table -e } else { table }" # run to display the output of a pipeline
          command_not_found: { null } # return an error message when a command is not found
      }
  menus: [
        # Configuration for default nushell menus
        # Note the lack of source parameter
        {
            name: completion_menu
            only_buffer_difference: false
            marker: ""
            type: {
                layout: columnar
                columns: 1
            }
            style: {
                text: green
                selected_text: { attr: r }
                description_text: yellow
                match_text: { attr: u }
                selected_match_text: { attr: ur }
            }
        }
    ],
      keybindings: [
    {
      name: ya
      modifier: Control
      keycode: Char_w
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: ExecuteHostCommand
        cmd: "ya"
      }
    },
    {
      name: edit_command_line
      modifier: Alt
      keycode: Char_e
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: OpenEditor
      }
    },
    {
      name: complete
      modifier: Alt
      keycode: Char_l
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          { send: HistoryHintWordComplete }          
          { edit: MoveWordRight }
        ]
      }
    },
    {
      name: complete
      modifier: Alt
      keycode: Char_j
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          { send: MenuDown }          
          { send: Down }
        ]
      }
    },
    {
      name: complete
      modifier: Alt
      keycode: Char_k
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          { send: MenuUp }          
          { send: Up }
        ]
      }
    },
  ],
  completions: {
    external: {
      enable: true
      completer: $completer
    }
  },
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2 # the precision for displaying floats in tables
  buffer_editor: "" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  use_ansi_coloring: true
  bracketed_paste: true # enable bracketed paste, currently useless on windows
  edit_mode: emacs # emacs, vi
  shell_integration: {
    # osc2 abbreviates the path if in the home_dir, sets the tab/window title, shows the running command in the tab/window title
    osc2: true
    # osc7 is a way to communicate the path to the terminal, this is helpful for spawning new tabs in the same directory
    osc7: true
    # osc8 is also implemented as the deprecated setting ls.show_clickable_links, it shows clickable links in ls output if your terminal supports it. show_clickable_links is deprecated in favor of osc8
    osc8: true
    # osc9_9 is from ConEmu and is starting to get wider support. It's similar to osc7 in that it communicates the path to the terminal
    osc9_9: false
    # osc133 is several escapes invented by Final Term which include the supported ones below.
    # 133;A - Mark prompt start
    # 133;B - Mark prompt end
    # 133;C - Mark pre-execution
    # 133;D;exit - Mark execution finished with exit code
    # This is used to enable terminals to know where the prompt is, the command is, where the command finishes, and where the output of the command is
    osc133: true
    # osc633 is closely related to osc133 but only exists in visual studio code (vscode) and supports their shell integration features
    # 633;A - Mark prompt start
    # 633;B - Mark prompt end
    # 633;C - Mark pre-execution
    # 633;D;exit - Mark execution finished with exit code
    # 633;E - NOT IMPLEMENTED - Explicitly set the command line with an optional nonce
    # 633;P;Cwd=<path> - Mark the current working directory and communicate it to the terminal
    # and also helps with the run recent menu in vscode
    osc633: true
    # reset_application_mode is escape \x1b[?1l and was added to help ssh work better
    reset_application_mode: true
  }
  render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
  use_kitty_protocol: true # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.
  highlight_resolved_externals: true # true enables highlighting of external commands in the repl resolved by which.

  cursor_shape: {
    vi_insert: line
    vi_normal: line
    emacs: line
  },
  table: {
    mode: rounded
  },
}


