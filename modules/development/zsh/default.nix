{ config, pkgs, ... }:

{
  imports = [
    ./aliases.nix
    ./environment.nix
    ./options.nix
    ./prompt.nix
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
  };
}
