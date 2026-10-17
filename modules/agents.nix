{
  config,
  pkgs,
  claude-code-nix,
  ...
}:

let
  configDir = config.home-manager.users.zemn.xdg.configHome;
  toolOutputDir = "/tmp/opencode/tool-output";
  claudeTmpDir = "/tmp/claude";

  opencode-patched = pkgs.opencode.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace packages/tui/src/routes/session/index.tsx \
        --replace-fail 'flexDirection="row" flexGrow={1} minHeight={0}' 'flexDirection="row-reverse" flexGrow={1} minHeight={0}' \
        --replace-fail 'alignItems="flex-end"' 'alignItems="flex-start"'
      substituteInPlace packages/opencode/src/tool/truncation-dir.ts \
        --replace-fail 'path.join(Global.Path.data, "tool-output")' '(process.env.OPENCODE_TOOL_OUTPUT_DIR || path.join(Global.Path.data, "tool-output"))'
    '';
  });
in
{
  fileSystems."${configDir}/agents" = {
    device = "100.64.100.10:/storage/agents";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
      "nfsvers=4"
      "rw"
    ];
  };

  home-manager.users.zemn = {
    home.packages = [
      claude-code-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    home.sessionVariables = {
      CLAUDE_CONFIG_DIR = "${configDir}/claude";
      CLAUDE_CODE_PROJECT_DIR_NAME = "default";
      CLAUDE_CODE_TMPDIR = claudeTmpDir;
      OPENCODE_TOOL_OUTPUT_DIR = toolOutputDir;
    };

    programs.opencode = {
      enable = true;
      package = opencode-patched;
    };

    systemd.user.tmpfiles.rules = [
      "d ${toolOutputDir} 0700 - - 1d"
    ];
  };
}
