{
  lib,
  pkgs,
  ...
}:
with lib;
let
  defaultApplications = {
    browser = "${pkgs.google-chrome}/share/applications/google-chrome.desktop";
    videoPlayer = "${pkgs.vlc}/share/applications/vlc.desktop";
    documentViewer = "${pkgs.papers}/share/applications/org.gnome.Papers.desktop";
    textEditor = "${pkgs.helix}/share/applications/Helix.desktop";
    fileManager = "${pkgs.yazi}/share/applications/yazi.desktop";
  };
  generateUserDirs =
    folderNames:
    let
      # Maps common folder names (capitalized) to their XDG attribute names (lowercase, often singular).
      # "Code" is not a standard XDG directory, so it's not included here.
      xdgAttributeMapping = {
        Downloads = "download";
        Documents = "documents";
        Pictures = "pictures";
        Desktop = "desktop";
        Music = "music";
        Public = "publicShare";
        Templates = "templates";
        Videos = "videos";
      };
    in
    builtins.listToAttrs (
      builtins.map (
        folderName:
        let
          # Get the corresponding XDG attribute name if it's a standard XDG dir
          xdgAttr = xdgAttributeMapping.${folderName} or null;
        in
        # Only generate an attribute if it's a standard XDG directory
        if xdgAttr != null then
          {
            name = xdgAttr;
            value = "/data/cabero/${folderName}";
          }
        else
          null # Filter out non-standard XDG folders like "Code" here
      ) (builtins.filter (folderName: xdgAttributeMapping ? ${folderName}) folderNames) # Filter input list to only include standard XDG dirs
    );

  generateTmpfilesRules =
    folderNames:
    builtins.map (folderName: "L %h/${folderName} - - - - /data/cabero/${folderName}") folderNames;

  # Function to generate systemd.tmpfiles.rules for creating /data/<username>/<folder> directories
  generateDataFolders =
    folderNames:
    let
      # Prepare rules for /data/cabero and /data/cabero/folderName
      # Assumes 'cabero' user and 'users' group exist
      baseRule = "d /data/cabero 0755 cabero users -";
    in
    [ baseRule ]
    ++ (builtins.map (folderName: "d /data/cabero/${folderName} 0755 cabero users -") folderNames);

  userDirs = [
    "Code"
    "Desktop"
    "GDrive"
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Public"
    "Templates"
    "Videos"
  ];
in
{

  home-manager.users.cabero = {
    systemd.user.tmpfiles.rules = (generateDataFolders userDirs) ++ (generateTmpfilesRules userDirs);
    xdg = {
      enable = true;
      userDirs = (generateUserDirs userDirs) // {
        enable = true;
        createDirectories = true;
      };

      mimeApps =
        let
          browserMimeTypes = (
            [ "text/html" ]
            ++ lib.lists.forEach [ "http" "https" "about" "unknown" ] (x: "x-scheme-handler/" + x)
          );
          videoMimeTypes = [
            "video/x-matroska"
            "video/mp4"
            "video/webm"
            "video/*"
          ];
          documentTypes = [ "application/pdf" ];
          textTypes = [
            "application/json"
            "text/plain"
            "text/markdown"
          ];
          folderTypes = [ "inode/directory" ];
        in
        {
          enable = true;
          defaultApplications = mkMerge [
            (lib.attrsets.genAttrs videoMimeTypes (name: defaultApplications.videoPlayer))
            (lib.attrsets.genAttrs browserMimeTypes (name: defaultApplications.browser))
            (lib.attrsets.genAttrs documentTypes (name: defaultApplications.documentViewer))
            (lib.attrsets.genAttrs textTypes (name: defaultApplications.textEditor))
            (lib.attrsets.genAttrs folderTypes (name: defaultApplications.fileManager))
          ];
        };
    };
  };
}
