{
  lib,
  isLinux ? false,
  isDarwin ? false,
  ...
}:

{
  imports = [
    ./home.nix
  ]
  ++ lib.optionals isLinux [ ./system-nixos.nix ]
  ++ lib.optionals isDarwin [ ./system-darwin.nix ];
}
