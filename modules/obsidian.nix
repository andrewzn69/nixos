{
  config,
  pkgs,
  obsidian-addons,
  ...
}:

let
  mkPlugin = name: settings: {
    enable = true;
    pkg = obsidian-addons.packages.${pkgs.system}.${name};
    inherit settings;
  };

  plugins = [
    "dataview"
    "templater-obsidian"
    "tag-wrangler"
    "omnisearch"
    "calendar"
    "obsidian-projects"
    "obsidian-vimrc-support"
    "obsidian-git"
    "obsidian-excalidraw-plugin"
    "excalibrain"
    "obsidian-plantuml"
    "copy-document-as-html"
    "obsidian-admonition"
    "copy-image"
    "image-converter"
    "obsidian-linter"
    "note-folder-autorename"
    "remember-cursor-position"
    "obsidian-scroll-offset"
    "obsidian-style-settings"
    "statusbar-organizer"
    "settings-search"
    "obsidian-auto-link-title"
    "blockreffer"
  ];

  pluginConfigs = builtins.listToAttrs (
    map (name: {
      name = name;
      value = mkPlugin name { };
    }) plugins
  );

in
{
  programs.obsidian = {
    enable = true;

    vaults = {
      knowledge = {
        path = "${config.home.homeDirectory}/docs/obsidian";

        settings = {
          communityPlugins = pluginConfigs // {
            obsidian-git = mkPlugin "obsidian-git" {
              commitMessage = "vault backup: {{date}}";
              autoCommitMessage = "vault backup: {{date}}";
              commitDateFormat = "YYYY-MM-DD HH:mm:ss";
              autoSaveInterval = 10;
              autoPushInterval = 10;
              autoPullInterval = 10;
              autoPullOnBoot = true;
              disablePush = false;
              pullBeforePush = true;
              disablePopups = true;
              listChangedFilesInMessageBody = false;
              showStatusBar = true;
              updateSubmodules = false;
              syncMethod = "merge";
              customMessageOnAutoBackup = false;
              autoBackupAfterFileChange = false;
              treeStructure = false;
              refreshSourceControl = true;
              basePath = "";
              differentIntervalCommitAndPush = false;
              changedFilesInStatusBar = false;
              showedMobileNotice = true;
              refreshSourceControlTimer = 7000;
              showBranchStatusBar = true;
              setLastSaveToLastCommit = false;
              submoduleRecurseCheckout = false;
              gitDir = "";
              showFileMenu = true;
              lineAuthor.show = false;
              autoCommitAfterFileChange = false;
            };
          };
        };
      };
    };
  };
}
