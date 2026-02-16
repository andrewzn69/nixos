{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Ondřej Zeman";
    userEmail = "ondrejzeman@zemn.xyz";

    aliases = {
      d = "difftool";
      s = "status";
      c = "commit";
      mergetool = "!nvim -c DiffviewOpen";
    };

    extraConfig = {
      credential.helper = "${pkgs.gitFull}/libexec/git-core/git-credential-libsecret";
      init.defaultBranch = "master";
      diff.tool = "nvimdiff";
      "diff \"nvimdiff\"".cmd = "nvim -c DiffviewOpen \"$LOCAL\" \"$REMOTE\"";
      core = {
        editor = "nvim";
        excludesFile = "~/.config/git/ignore";
      };
    };
  };

  home.packages = with pkgs; [
    git-filter-repo
  ];
}
