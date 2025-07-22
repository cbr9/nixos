{
  lib,
  pkgs,
  ...
}:
with lib;
let
  defaultApplications = {
    browser = "google-chrome.desktop";
    videoPlayer = "vlc.desktop";
    documentViewer = "org.gnome.Evince.desktop";
    textEditor = "Helix.desktop";
    fileManager = "yazi.desktop";
  };
in
{
  home-manager.users.cabero = {
    home.packages = with pkgs; [
      vlc
      evince
    ];
    xdg = {
      enable = true;
      userDirs = {
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
