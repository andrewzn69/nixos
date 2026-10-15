{ ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  nixpkgs.overlays = [
    (final: prev: {
      # nixpkgs rewrites the dtc flags for its own dtc but uboot-asahi builds with the older dtc bundled in uboot
      uboot-asahi = prev.uboot-asahi.overrideAttrs (o: {
        postPatch = o.postPatch + ''
          for f in scripts/Makefile.lib dts/upstream/Makefile; do
            substituteInPlace "$f" --replace-fail -Eno-node_name_not_empty -Wno-graph_child_address
          done
        '';
      });
    })
  ];
}
