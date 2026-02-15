{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    clock24 = true;
    keyMode = "vi";
    baseIndex = 1;
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
          set -g @resurrect-save-shell-history 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
    ];

    extraConfig = ''
      # terminal features
      set-option -sa terminal-features ',xterm-256color:RGB'
      set -g set-clipboard on
      set -g detach-on-destroy off

      # extended keys
      set -s extended-keys on
      set -as terminal-features 'xterm*:extkeys'

      # pane numbering
      set -g pane-base-index 1
      set -g renumber-windows on

      # cursor shape passthrough
      set-option -g terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[ q'

      # copy mode vi binds
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
      bind-key -T copy-mode-vi 'r' send -X rectangle-toggle

      # session rename
      bind R command-prompt -I "#{session_name}" "rename-session '%%'"

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
      set -g status-left "#[fg=colour6,bold] #S #[fg=colour8]│ "

      # Status right (path, CPU, RAM)
      set -g status-right "#{?window_zoomed_flag,#[fg=colour7][f] #[fg=colour8]│ ,}#[fg=colour6] #[fg=colour7]#([ #{pane_current_path} = $HOME ] && echo '~' || basename #{pane_current_path}) #[fg=colour8]│ #[fg=colour6]󰍛 #[fg=colour7]#(top -bn1 | grep 'Cpu(s)' | awk '{print 100 - $8\"%\"}') #[fg=colour8]│ #[fg=colour6]  #[fg=colour7]#(free --si | awk '/^Mem/ { printf(\"%.1fG/%.1fG\", \$3/1000000, \$2/1000000) }' | tr ',' '.') "

      # copy mode
      set -g mode-style "bg=colour2,fg=colour0"

      # clock mode
      set -g clock-mode-colour "colour2"
    '';
  };
}
