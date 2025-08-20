{
  inputs,
  system,
  ...
}:
let
in
{
  nixpkgs.pkgs = import inputs.nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      rocmSupport = true;
    };
  };
}
