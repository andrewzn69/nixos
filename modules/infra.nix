{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # kubernetes
    kubectl
    kubernetes-helm
    k9s
    kubectx
    # argocd # broken in nixpkgs 3.3.0 - fetchYarnDeps hash mismatch
    kubeseal

    # iac
    terraform
    talosctl

    # providers
    oci-cli
  ];
}
