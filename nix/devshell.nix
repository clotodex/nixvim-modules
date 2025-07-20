{inputs, ...}: {
  perSystem = {
    config,
    self',
    inputs',
    pkgs,
    system,
    ...
  }: let
    nixvim' = inputs.nixvim.legacyPackages."${system}";
    #nvim = nixvim'.makeNixvim config;
    #nvim = nixvim'.makeNixvim {
    #  plugins.lsp.enable = true;
    #};

    nixvimLib = inputs.nixvim.lib.${system};

    nixvimModule = {
      inherit pkgs;
      module = import ../config; # import the module directly
      # You can use `extraSpecialArgs` to pass additional arguments to your module files
      extraSpecialArgs = {
        # inherit (inputs) foo;
      };
    };
    nvim = nixvim'.makeNixvimWithModule nixvimModule;
  in {
    checks = {
      # Run `nix flake check .` to verify that your config is not broken
      default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
    };

    packages = {
      # Lets you run `nix run .` to start nixvim
      default = nvim;
    };
  };
}
