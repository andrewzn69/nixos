{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Ondřej Zeman";
        email = "ondrejzeman@zemn.xyz";
      };
      credential = {
        helper = "store";
      };
      init = {
        defaultBranch = "master";
      };
      diff = {
        tool = "nvimdiff";
      };
      alias = {
        d = "difftool";
        s = "status";
        c = "commit";
        mergetool = "!nvim -c DiffviewOpen";
      };
      "diff \"nvimdiff\"" = {
        cmd = "nvim -c DiffviewOpen \"$LOCAL\" \"$REMOTE\"";
      };
      core = {
        editor = "nvim";
        excludesFile = "/home/zemn/.config/git/ignore";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    git-filter-repo
  ];
}
