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
        helper = "${pkgs.gitFull}/libexec/git-core/git-credential-libsecret";
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
        excludesFile = "~/.config/git/ignore";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    git-filter-repo
  ];
}
