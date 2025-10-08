{ config, pkgs, ... }:

{
  programs.fish = {
    loginShellInit = ''
      # auto-start tmux on ssh login
      if status is-login; and test -n "$SSH_CONNECTION"; and not set -q TMUX
        if not tmux has-session -t knowledgebase 2>/dev/null
          tmux new-session -d -s knowledgebase -n main -c /home/zemn/Development/knowledgebase
          tmux send-keys -t knowledgebase:main "claude @CLAUDE.md @JOURNAL.md @PROJECTS.md" C-m
          tmux split-window -t knowledgebase:main -h -c /home/zemn
          tmux new-window -t knowledgebase -n git -c /home/zemn
          tmux select-window -t knowledgebase:main
          tmux select-pane -t knowledgebase:main.0
        end
        exec tmux attach-session -t knowledgebase
      end
    '';
  };
}
