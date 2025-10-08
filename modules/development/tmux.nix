{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    clock24 = true;
    keyMode = "vi";
    baseIndex = 1;
    escapeTime = 0;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      continuum
    ];

    extraConfig = ''
            # terminal features
            set-option -sa terminal-features ',xterm-256color:RGB'
            set -g focus-events on
            set -g set-clipboard on
            set -g detach-on-destroy off
            set -g mouse on

            # enable extended keys for ctrl+shift combinations
            set -s extended-keys on
            set -as terminal-features 'xterm*:extkeys'

            # start numbering from 1
            set -g pane-base-index 1
            set -g renumber-windows on

            # terminal cursor shape changes
            set-option -g terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[ q'

            # copy mode binds
						bind -n C-S-Escape copy-mode
            bind-key -T copy-mode-vi 'v' send -X begin-selection
            bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
            bind-key -T copy-mode-vi 'r' send -X rectangle-toggle

            # session rename using prefix + R
            bind R command-prompt -I "#{session_name}" "rename-session '%%'"

            # window rename
						bind -n C-S-R command-prompt -I "#{window_name}" "rename-window '%%'"

            # window management
            bind -n C-w kill-window
            bind-key -n C-S-H previous-window
            bind-key -n C-S-L next-window
						bind-key -n C-S-I next-window # ctrl+tab (terminal sends ctrl+shift+i)
						bind-key -n C-S-N previous-window # ctr+shift+tab
            bind -n C-D detach-client

            # pane creation with Ctrl+t+h/j/k/l (Ctrl+t enters pane_create mode)
            bind -n C-t switch-client -T pane_create
            bind -T pane_create h split-window -hb -c "#{pane_current_path}"
            bind -T pane_create l split-window -h -c "#{pane_current_path}"
            bind -T pane_create j split-window -v -c "#{pane_current_path}"
            bind -T pane_create k split-window -vb -c "#{pane_current_path}"
            bind -T pane_create t new-window -c "#{pane_current_path}"

            # pane navigation
            bind -n C-h select-pane -L
            bind -n C-j select-pane -D
            bind -n C-k select-pane -U
            bind -n C-l select-pane -R

            # plugin settings
            set -g @resurrect-capture-pane-contents 'on'
            set -g @continuum-restore 'on'
            set -g @resurrect-save-shell-history 'on'

            # theme colors
            BG_COLOR="#1A1D23"
            ACTIVE_COLOR="#b4befe"
            INACTIVE_COLOR="#6c7086"
            TEXT_COLOR="#cdd6f4"
            ACCENT_COLOR="#b4befe"

            # status bar
            set -g status on
            set -g status-position bottom
            set -g status-interval 3
            set -g status-justify left
            set -g status-style "bg=$BG_COLOR,fg=$TEXT_COLOR"
            set -g status-left-length 100
            set -g status-right-length 100

            # pane borders
            set -g pane-border-style "fg=#44475a"
            set -g pane-active-border-style "fg=$ACTIVE_COLOR"

            # message style
            set -g message-style "bg=$BG_COLOR,fg=$TEXT_COLOR,bold"
            set -g message-command-style "bg=$BG_COLOR,fg=$TEXT_COLOR,bold"

            # window status format
            set -g window-status-format "#[fg=$INACTIVE_COLOR,bg=$BG_COLOR] #I:#W "
            set -g window-status-current-format "#[fg=$ACTIVE_COLOR,bg=$BG_COLOR,bold] #I:#W "
            set -g window-status-separator ""

            # status left (session name)
            set -g status-left "#[fg=$ACCENT_COLOR,bold]  #S #[fg=$INACTIVE_COLOR]│ "

            # Status right (path, RAM, date, time, battery)
            set -g status-right "\
      #[fg=$ACCENT_COLOR] #[fg=$TEXT_COLOR]#([ #{pane_current_path} = $HOME ] && echo '~' || basename #{pane_current_path}) \
      #[fg=$INACTIVE_COLOR]│ \
      #[fg=$ACCENT_COLOR] #[fg=$TEXT_COLOR]#(free | awk '/^Mem/ { printf(\"%.0f%%\", $3/$2 * 100 - 0.5) }' ) \
      #[fg=$INACTIVE_COLOR]│ \
      #[fg=$ACCENT_COLOR] #[fg=$TEXT_COLOR]#(date +%d) \
      #[fg=$INACTIVE_COLOR]│ \
      #[fg=$ACCENT_COLOR] #[fg=$TEXT_COLOR]#(date +%H:%M) \
      #[fg=$INACTIVE_COLOR]│ \
      #[fg=$ACCENT_COLOR] #[fg=$TEXT_COLOR]#(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo 'N/A')% "

            # copy mode styling
            set -g mode-style "bg=$ACTIVE_COLOR,fg=$BG_COLOR"

            # clock mode
            set -g clock-mode-colour "$ACTIVE_COLOR"
    '';
  };
}
