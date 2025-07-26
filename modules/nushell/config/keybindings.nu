let keybindings = [
    {
        name: yazi
        modifier: control
        keycode: char_w
        mode: emacs
        event: {
            send: ExecuteHostCommand
            cmd: "yy"
        }
    }
]

$env.config = $env.config | upsert keybindings $keybindings
