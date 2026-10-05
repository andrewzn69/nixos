{ pkgs, ... }:

let
  opencode-sidebar-left = pkgs.opencode.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace packages/tui/src/routes/session/index.tsx \
        --replace-fail 'flexDirection="row" flexGrow={1} minHeight={0}' 'flexDirection="row-reverse" flexGrow={1} minHeight={0}' \
        --replace-fail 'alignItems="flex-end"' 'alignItems="flex-start"'
    '';
  });
in
{
  programs.opencode = {
    enable = true;
    package = opencode-sidebar-left;
  };
}
