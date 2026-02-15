{ ... }:

{
  programs.fish.enable = true;

  imports = [
    ./config/aliases.nix
    ./config/prompt.nix
  ];
}
