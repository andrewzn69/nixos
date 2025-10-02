{ config, pkgs, ... }:

{
  programs.fish.interactiveShellInit = ''
    function fish_prompt
        set_color green
        echo -n "󰁕 "
        set_color blue
        echo -n (prompt_pwd --dir-length=0)

        if git rev-parse --git-dir >/dev/null 2>&1
            set_color green
            echo -n " ("
            set_color white
            echo -n " "(git rev-parse --abbrev-ref HEAD)
            set_color green
            echo -n ")"
        end

        set_color normal
        echo -n " "
    end
  '';
}
