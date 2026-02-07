{ config, pkgs, ... }:

{
  programs.obsidian = {
    enable = true;

    vaults = {
      knowledge = {
        path = "${config.home.homeDirectory}/docs/obsidian";

        # Community plugins to install and enable
        community-plugins = [
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

          # ui/ux improvements
          "remember-cursor-position"
          "obsidian-scroll-offset"
          "obsidian-style-settings"
          "statusbar-organizer"
          "settings-search"

          # utilities
          "obsidian-auto-link-title"
          "blockreffer"
        ];

        # Plugin configurations
        plugin-config = {
          obsidian-git = {
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
            lineAuthor = {
              show = false;
            };
            autoCommitAfterFileChange = false;
          };
        };
      };
    };
  };
}
