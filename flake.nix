{
  description = ''
    ## nixvim modules
    A lfake for an opinionated nixvim setup
    nix develop will load the default config
    using this flake as an input allows to inherit defaults as well as configure on top
  '';

  inputs = {
    nixvim.
      url = "github:nix-community/nixvim";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./nix/devshell.nix
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
}
