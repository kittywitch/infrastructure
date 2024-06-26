{pkgs, ...}: {
  home.packages = with pkgs; [
    # IAC

    terraform # iac tool

    # Kubernetes

    kubectl # kubectl
    k9s # cute k8s client, canines~
    kubernetes-helm # k8s package manager
    kustomize # config management and patching, ...

    # AWS

    awscli2 # awscli v2

    # Nix

    deadnix # nix dead-code scanner
    alejandra # nix code formatter
    statix # nix anti-pattern finder
    deploy-rs.deploy-rs # deployment system
  ];
}
