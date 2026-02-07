{ config, pkgs, ... }:

let
  vaultPath = "${config.home.homeDirectory}/docs/obsidian";
in
{
  home.packages = [ pkgs.obsidian ];

  home.file."${vaultPath}/.obsidian/community-plugins.json" = {
    force = true;
    text = builtins.toJSON [
      # core zettelkasten
      "dataview"
      "templater-obsidian"
      "tag-wrangler"

      # navigation & search
      "omnisearch"
      "calendar"
      "obsidian-projects"

      # editor & git
      "obsidian-vimrc-support"
      "obsidian-git"

      # diagrams & visualization
      "obsidian-excalidraw-plugin"
      "excalibrain"
      "obsidian-plantuml"

      # export & content
      "copy-document-as-html"
      "obsidian-admonition"

      # media handling
      "copy-image"
      "image-converter"

      # automation
      "obsidian-linter"
      "note-folder-autorename"

      # ui/ux Improvements
      "remember-cursor-position"
      "obsidian-scroll-offset"
      "obsidian-style-settings"
      "statusbar-organizer"
      "settings-search"

      # utils
      "obsidian-auto-link-title"
      "blockreffer"
    ];
  };

  # obsidian-git config
  home.file."${vaultPath}/.obsidian/plugins/obsidian-git/data.json" = {
    force = true; # Overwrite existing file
    text = builtins.toJSON {
      commitMessage = "vault backup: {{date}}";
      autoCommitMessage = "vault backup: {{date}}";
      commitDateFormat = "YYYY-MM-DD HH:mm:ss";
      autoSaveInterval = 10; # auto commit every 10 minutes
      autoPushInterval = 10; # auto push every 10 minutes
      autoPullInterval = 10; # auto pull every 10 minutes
      autoPullOnBoot = true;
      disablePush = false;
      pullBeforePush = true;
      disablePopups = true; # no notification spam
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
      lineAuthor = {
        show = false;
      };
      autoCommitAfterFileChange = false;
    };
  };
}
