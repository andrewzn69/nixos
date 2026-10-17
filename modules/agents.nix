{
  lib,
  config,
  pkgs,
  user,
  claude-code-nix,
  ...
}:

let
  configDir = config.home-manager.users.${user}.xdg.configHome;
  agentsDir = "${configDir}/agents";
  claudeTmpDir = "/tmp/claude";
  opencodeTmpDir = "/tmp/opencode";

  inherit (config.home-manager.users.${user}.lib.file) mkOutOfStoreSymlink;

  links = {
    claude = {
      "CLAUDE.md" = "${agentsDir}/AGENTS.md";
      rules = "${agentsDir}/rules";
      skills = "${agentsDir}/skills";
      agents = "${agentsDir}/claude/agents";
      hooks = "${agentsDir}/claude/hooks";
      "settings.json" = "${agentsDir}/claude/settings.json";
      "keybindings.json" = "${agentsDir}/claude/keybindings.json";
      "claude-powerline.json" = "${agentsDir}/claude/claude-powerline.json";
      jobs = "${claudeTmpDir}/jobs";
      plans = "${claudeTmpDir}/plans";
      session-env = "${claudeTmpDir}/session-env";
      shell-snapshots = "${claudeTmpDir}/shell-snapshots";
    };
  };

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
  fileSystems.${agentsDir} = {
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

  home-manager.users.${user} = {
    home.packages = [
      claude-code-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    home.sessionVariables = {
      CLAUDE_CONFIG_DIR = "${configDir}/claude";
      CLAUDE_CODE_PROJECT_DIR_NAME = "default";
      CLAUDE_CODE_TMPDIR = claudeTmpDir;
      CLAUDE_CODE_DEBUG_LOGS_DIR = "${claudeTmpDir}/debug.txt";
      CLAUDE_CODE_DISABLE_FILE_CHECKPOINTING = "1";
      CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1";
      CLAUDE_CODE_DISABLE_AUTO_MEMORY = "1";
      CLAUDE_CODE_DISABLE_GIT_INSTRUCTIONS = "1";
      CLAUDE_CODE_HIDE_CWD = "1";
      CLAUDE_CODE_DISABLE_OFFICIAL_MARKETPLACE_AUTOINSTALL = "1";
      CLAUDE_CODE_DISABLE_ADVISOR_TOOL = "1";
      CLAUDE_CODE_DISABLE_WEB_FETCH = "1";
      CLAUDE_CODE_FORCE_TERMINAL_IMAGES = "1";
      CLAUDE_CODE_FORK_SUBAGENT = "0";
      CLAUDE_CODE_GLOB_NO_IGNORE = "false";
      CLAUDE_CODE_NATIVE_CURSOR = "1";
      CLAUDE_CODE_TMUX_TRUECOLOR = "1";
      DISABLE_AUTO_COMPACT = "1";
      DISABLE_DOCTOR_COMMAND = "1";
      DISABLE_EXTRA_USAGE_COMMAND = "1";
      DISABLE_INSTALL_GITHUB_APP_COMMAND = "1";
      DISABLE_UPGRADE_COMMAND = "1";
      DO_NOT_TRACK = "1";
      USE_BUILTIN_RIPGREP = "0";
      OPENCODE_TOOL_OUTPUT_DIR = "${opencodeTmpDir}/tool-output";
    };

    xdg.configFile = lib.concatMapAttrs (
      tool: files:
      lib.mapAttrs' (
        name: target: lib.nameValuePair "${tool}/${name}" { source = mkOutOfStoreSymlink target; }
      ) files
    ) links;

    programs.opencode = {
      enable = true;
      package = opencode-patched;
    };

    systemd.user.tmpfiles.rules = [
      "d ${claudeTmpDir} 0700 - - 1d"
      "d ${claudeTmpDir}/jobs 0700 - -"
      "X ${claudeTmpDir}/jobs"
      "d ${claudeTmpDir}/plans 0700 - -"
      "X ${claudeTmpDir}/plans"
      "d ${claudeTmpDir}/session-env 0700 - -"
      "X ${claudeTmpDir}/session-env"
      "d ${claudeTmpDir}/shell-snapshots 0700 - -"
      "x ${claudeTmpDir}/shell-snapshots"
      "e ${configDir}/claude/projects - - - mM:3d"
      "d ${opencodeTmpDir} 0700 - - 1d"
    ];
  };
}
