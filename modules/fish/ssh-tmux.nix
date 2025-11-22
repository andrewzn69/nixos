{ ... }:

{
  programs.fish = {
    loginShellInit = ''
      # auto-start tmux on ssh login
      if status is-login; and test -n "$SSH_CONNECTION"; and not set -q TMUX
        if not tmux has-session -t  2>/dev/null
          tmux new-session -d -s dev -n main -c /home/zemn/Development/knowledgebase
          tmux send-keys -t dev:main "claude @CLAUDE.md @JOURNAL.md @PROJECTS.md" C-m
          tmux split-window -t dev:main -h -c /home/zemn
          tmux new-window -t dev -n git -c /home/zemn
          tmux select-window -t dev:main
          tmux select-pane -t dev:main.0
        end
        exec tmux attach-session -t dev 
      end
    '';
  };
}
