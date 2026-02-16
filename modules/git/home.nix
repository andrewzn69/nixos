{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Ondřej Zeman";
      user.email = "ondrejzeman@zemn.xyz";

      alias = {
        d = "difftool";
        s = "status";
        c = "commit";
        mergetool = "!nvim -c DiffviewOpen";
      };

      credential.helper = "${pkgs.gitFull}/libexec/git-core/git-credential-libsecret";
      init.defaultBranch = "master";
      diff.tool = "nvimdiff";
      "diff \"nvimdiff\"".cmd = "nvim -c DiffviewOpen \"$LOCAL\" \"$REMOTE\"";
      core = {
        editor = "nvim";
        excludesFile = "~/.config/git/ignore";
      };
      "url \"git@github.com:\"".insteadOf = "https://github.com/";
    };
  };

  home.packages = with pkgs; [
    git-filter-repo
  ];
}
