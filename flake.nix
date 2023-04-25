{
  description = "the katzian monorepo effort";
  inputs = {
    # to allow non-nix 2.4 evaluation
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    # better than nixpkgs.lib
    std = {
      url = "github:chessai/nix-std";
    };
    # used for overriding unwanted flake inputs
    empty.url = "github:input-output-hk/empty-flake";
    # self-explanatory
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # deployments
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };
    # self-explanatory
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    # self-explanatory
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # status bar
    spacebar = {
      url = "github:cmacrae/spacebar/v1.4.0";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "utils";
      };
    };
    # WSL host
    wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "utils";
        flake-compat.follows = "flake-compat";
      };
    };
    # flake-utils
    systems = {
      url = "path:/home/kat/src/systems";
    };
    utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    # file structure -> attrset
    tree = {
      url = "github:kittywitch/tree";
      inputs.std.follows = "std";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hardware quirks
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # secrets templating
    scalpel = {
      url = "github:polygon/scalpel";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        sops-nix.follows = "sops-nix";
      };
    };
    # dependency database for mach-nix
    pypi-deps-db = {
      url = "github:DavHau/pypi-deps-db";
      flake = false;
    };
    # nixified python environments
    mach-nix = {
      url = "mach-nix/3.5.0";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "utils";
        pypi-deps-db.follows = "pypi-deps-db";
      };
    };
    # pre-computed nix-index
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # a bunch of modules (also arcnmx is good)
    arcexprs = {
      url = "github:arcnmx/nixexprs/master";
      flake = false;
    };
  };
  outputs = inputs: import ./outputs.nix {inherit inputs;};
}
