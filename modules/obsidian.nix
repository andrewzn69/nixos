{ pkgs, ... }:

{
  home.packages = [ pkgs.obsidian ];

  # plugins to install manually (settings -> community plugins -> browse):
  # - dataview
  # - templater-obsidian
  # - tag-wrangler
  # - omnisearch
  # - calendar
  # - obsidian-projects
  # - obsidian-vimrc-support
  # - obsidian-git
  # - obsidian-excalidraw-plugin
  # - excalibrain
  # - obsidian-plantuml
  # - copy-document-as-html
  # - obsidian-admonition
  # - copy-image
  # - image-converter
  # - obsidian-linter
  # - note-folder-autorename
  # - remember-cursor-position
  # - obsidian-scroll-offset
  # - obsidian-style-settings
  # - statusbar-organizer
  # - settings-search
  # - obsidian-auto-link-title
  # - blockreffer
}
