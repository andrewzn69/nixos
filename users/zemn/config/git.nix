{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Ondřej Zeman";
      user.email = "ondrejzeman@zemn.xyz";
      github.user = "andrewzn69";

      alias = {
        d = "difftool";
        s = "status";
        c = "commit";
        m = "!nvim -c DiffviewOpen";
      };

      credential.helper = "${pkgs.gitFull}/libexec/git-core/git-credential-libsecret";
      init.defaultBranch = "master";
      diff.tool = "nvimdiff";
      core = {
        editor = "nvim";
        excludesFile = "~/.config/git/ignore";
      };
      "url \"git@github.com:\"".pushInsteadOf = "https://github.com/";
      "url \"git@github.com:andrewzn69/\"".insteadOf = "https://github.com/andrewzn69/";
    };
  };

  home.packages = with pkgs; [
    git-filter-repo
  ];
}
