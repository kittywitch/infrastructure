_: let
  hostConfig = {
    tree,
    pkgs,
    inputs,
    lib,
    ...
  }: let
    inherit (lib.strings) concatStringsSep;
  in {
    imports = with tree; [
      kat.work
    ];

    security.pam.enableSudoTouchIdAuth = true;

    home-manager.users.root.programs.ssh = {
      enable = true;
      extraConfig = ''
        Host renko
          HostName 127.0.0.1
          Port 32222
          User kat
          IdentityFile /Users/kat/.orbstack/ssh/id_ed25519
      '';
    };

    nix.buildMachines = [
      {
        hostName = "renko";
        system = "aarch64-linux";
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
      }
      {
        hostName = "renko";
        system = "x86_64-linux";
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
      }
    ];

    nix.distributedBuilds = true;
    nix.extraOptions = ''
      builders-use-substitutes = true
    '';

    environment.systemPackages = with pkgs; [
      inputs.artemiscli.packages.aarch64-darwin.artemiscli
      fd # fd, better fine!
      ripgrep # rg, better grep!
      deadnix # dead-code scanner
      alejandra # code formatter
      statix # anti-pattern finder
      deploy-rs.deploy-rs # deployment system
      rnix-lsp # vscode nix extensions
      terraform # terraform
      kubectl # kubernetes
      k9s # cute k8s client, canines~
      kubernetes-helm # helm
      awscli
    ];

    home-manager.users.kat = {
      home.file.".orbstack/ssh/authorized_keys".text =
        (concatStringsSep "\n" tree.kat.user.data.keys)
        + ''

          ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILW2V8yL2vC/KDmIQdxhEeevKo1vGG18bvMNj9mLL/On
        '';
      programs = {
        zsh = {
          initExtra = ''
            source <(kubectl completion zsh)
          '';
        };
        ssh = {
          enable = true;
          extraConfig = ''
            Host renko
              HostName 127.0.0.1
              Port 32222
              User kat
              IdentityFile /Users/kat/.orbstack/ssh/id_ed25519
          '';
        };
      };
    };

    homebrew = {
      brewPrefix = "/opt/homebrew/bin";
      brews = [
        "gnupg"
        "pinentry-mac"
        "awscurl"
        "pandoc"
      ];
      casks = [
        "barrier"
        "bitwarden"
        "firefox"
        "disk-inventory-x"
        "dozer"
        "devtoys"
        "cyberduck"
        "spotify"
        "pycharm-ce"
        "element"
        "slack"
        "boop"
        "obsidian"
        "contexts"
        "rectangle"
        "signal"
        "telegram"
        "discord"
        "deluge"
        "keybase"
        "anki"
        "firefox"
        "google-chrome"
        "orbstack"
      ];
      taps = [
        "pulumi/tap"
      ];
      masApps = {
        Tailscale = 1475387142;
        Dato = 1470584107;
        Lungo = 1263070803;
        "Battery Indicator" = 1206020918;
      };
    };

    system.stateVersion = 4;
  };
in {
  arch = "aarch64";
  type = "macOS";
  modules = [
    hostConfig
  ];
}
