{
  pkgs,
  config,
  lib,
  ...
}:
let
  sshMatchBlocks = config.programs.ssh.matchBlocks;

  # Check if the "*" block actually contains identityAgent
  wildcardBlock = sshMatchBlocks."*".data or { };
  identityAgent = builtins.elemAt wildcardBlock.identityAgent 0;

  # Filter out wildcard hosts (containing * or ?)
  isWildcard = name: lib.hasInfix "*" name || lib.hasInfix "?" name;
  filteredHosts = lib.filterAttrs (name: _: !isWildcard name) sshMatchBlocks;

  hostToKeybinding =
    name: hostConfig:
    let
      cfg = hostConfig.data or { };
      host = if (cfg.hostname or null) != null then cfg.hostname else name;
    in
    {
      on = [
        "g"
        "s"
        (builtins.substring 0 1 name)
      ];
      run = "cd sftp://${name}/";
      desc = "${host}";
    };

  hostToVfs =
    name: hostConfig:
    let
      cfg = hostConfig.data or { };
      host = if (cfg.hostname or null) != null then cfg.hostname else name;
      port = if (cfg.port or null) != null then cfg.port else 22;
      user = if (cfg.user or null) != null then cfg.user else "cabero";
    in
    ''
      [services.${name}]
      type = "sftp"
      host = "${host}"
      user = "${user}"
      port = ${toString port}
    ''
    + lib.optionalString (identityAgent != null) ''
      identity_agent = ${identityAgent}
    '';

  dynamicKeymaps = lib.mapAttrsToList hostToKeybinding filteredHosts;
  vfsContent = lib.concatStringsSep "\n" (lib.mapAttrsToList hostToVfs filteredHosts);

in
{
  imports = [
    ./plugins
    ./settings.nix
    ./keymap.nix
  ];

  home.packages = with pkgs; [
    exiftool
  ];

  home.file.".config/yazi/vfs.toml".text = vfsContent;

  programs.yazi = {
    enable = true;
    initLua = ./init.lua;
    keymap.mgr.prepend_keymap = dynamicKeymaps;
  };
}
