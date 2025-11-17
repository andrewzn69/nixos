{ ... }:

{
  programs.fish.interactiveShellInit = ''
    bind ctrl-space 'clear; commandline -f repaint'
    bind \e\x7f backward-kill-word  # Ctrl+Backspace (Kitty sends Alt+Backspace)
  '';
}
