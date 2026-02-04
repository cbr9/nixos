lib: rec {
  # Platform detection helpers
  isDarwin = system: lib.hasSuffix "-darwin" system;
  isLinux = system: lib.hasSuffix "-linux" system;
  forPlatform =
    system:
    {
      darwin ? null,
      linux ? null,
      default ? null,
    }:
    if isDarwin system then
      (if darwin != null then darwin else default)
    else if isLinux system then
      (if linux != null then linux else default)
    else
      default;
  indexOf =
    element: list:
    let
      helper =
        list: index:
        if list == [ ] then
          null
        else if builtins.head list == element then
          index
        else
          helper (lib.lists.drop 1 list) (index + 1);
    in
    helper list 0;

  # sorts a list of attribute sets by comparing a field in each of the attrsets, with a user-defined order
  sortAttrsList =
    path: list: order:
    builtins.sort (
      a: b:
      (lib.indexOf (lib.attrsets.getAttrFromPath path a) order)
      < (lib.indexOf (lib.attrsets.getAttrFromPath path b) order)
    ) list;

  boolToString = bool: if bool == true then "true" else "false";

  getFilesFromDir =
    dir:
    builtins.filter (name: builtins.isPath (dir + "/${name}")) (
      builtins.attrNames (builtins.readDir dir)
    );

  createSymlinksForDirectory =
    { sourceDir, targetRelativePath }:
    builtins.listToAttrs (
      builtins.map (file: {
        name = "${targetRelativePath}/${file}"; # Construct the full target path
        value = {
          source = "${sourceDir}/${file}"; # Construct the full source path
          force = true;
        };
      }) (getFilesFromDir sourceDir)
    );
}
