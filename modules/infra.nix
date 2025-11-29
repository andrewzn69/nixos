{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # kubernetes
    kubectl
    kubernetes-helm
    k9s
    kubectx
    argocd
    kubeseal

    # iac
    terraform
    talosctl

    # providers
    oci-cli
  ];
}
