{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "dev" ''
      set -euo pipefail

      roots=("$HOME/Development" "$HOME/.config")

      arg="''${1:-}"
      if [ -z "$arg" ]; then
        root=$(git rev-parse --show-toplevel 2> /dev/null || echo "$PWD")
        name=$(basename "$root")
      else
        name="$arg"
        root=""
        for r in "''${roots[@]}"; do
          for candidate in "$r/$name" "$r"/*/"$name"; do
            if [ -d "$candidate" ]; then
              root="$candidate"
              break 2
            fi
          done
        done
        if [ -z "$root" ]; then
          echo "dev: no directory named '$name' under ''${roots[*]}" >&2
          exit 1
        fi
      fi

      # tmux addresses windows as session:window, so those two are not usable in a name
      session=$(printf '%s' "$name" | tr '.:' '__')

      enter() {
        if [ -n "''${TMUX:-}" ]; then
          exec tmux switch-client -t "=$session"
        fi
        exec tmux attach -t "=$session"
      }

      # =session is an exact match, otherwise `dev nix` finds `nixos`
      if tmux has-session -t "=$session" 2> /dev/null; then
        enter
      fi

      tmux new-session -d -s "$session" -c "$root" -n shell
      tmux new-window -t "=$session:1" -c "$root" -n edit nvim
      tmux new-window -t "=$session:2" -c "$root" -n cluster k9s
      tmux new-window -t "=$session:3" -c "$root" -n watch
      tmux new-window -t "=$session:4" -c "$root" -n scratch
      tmux select-window -t "=$session:0"
      enter
    '')
  ];

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    clock24 = true;
    keyMode = "vi";
    escapeTime = 0;
    mouse = true;
    historyLimit = 10000;
    focusEvents = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
    ];

    extraConfig = ''
      # terminal features
      set-option -sa terminal-features ',xterm-256color:RGB'
      set -g set-clipboard on

      # extended keys
      set -s extended-keys on
      set -as terminal-features 'xterm*:extkeys'

      set -g renumber-windows on

      # cursor shape passthrough
      set-option -g terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[ q'

      # status bar
      set -g status on
      set -g status-position bottom
      set -g status-interval 3
      set -g status-justify left
      set -g status-style "bg=colour0,fg=colour7"
      set -g status-left-length 100
      set -g status-right-length 100

      # pane borders
      set -g pane-border-style "fg=colour8"
      set -g pane-active-border-style "fg=colour2"
      set -g window-style "bg=default"
      set -g window-active-style "bg=default"

      # messages
      set -g message-style "bg=colour0,fg=colour7,bold"
      set -g message-command-style "bg=colour0,fg=colour7,bold"

      # window status
      set -g window-status-format "#[fg=colour8,bg=colour0] #I:#W "
      set -g window-status-current-format "#[fg=colour2,bg=colour0,bold] #I:#W "
      set -g window-status-separator ""

      # status left (session name)
      set -g status-left "#[fg=colour4,bold] #S #[fg=colour8]│ "

      # Status right (path, CPU, RAM)
      set -g status-right "#{?window_zoomed_flag,#[fg=colour7][f] #[fg=colour8]│ ,}#[fg=colour4]󰉋 #[fg=colour7]#([ #{pane_current_path} = $HOME ] && echo '~' || basename #{pane_current_path}) #[fg=colour8]│ #[fg=colour4]󰍛 #[fg=colour7]#(top -bn1 | grep 'Cpu(s)' | awk '{print 100 - $8\"%\"}') #[fg=colour8]│ #[fg=colour4]  #[fg=colour7]#(free --si | awk '/^Mem/ { printf(\"%.1fG/%.1fG\", \$3/1000000, \$2/1000000) }' | tr ',' '.') "

      # copy mode
      set -g mode-style "bg=colour2,fg=colour0"

      # clock mode
      set -g clock-mode-colour "colour2"
    '';
  };
}
