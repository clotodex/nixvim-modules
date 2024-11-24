{inputs, ...}: {
  imports = [
    inputs.devenv.flakeModule
  ];

  perSystem = {
    config,
    self',
    inputs',
    pkgs,
    system,
    ...
  }: let
    nixvim' = inputs.nixvim.legacyPackages."${system}";
    # nvim = nixvim'.makeNixvim config;
    nvim = nixvim'.makeNixvim {
      plugins.lsp.enable = true;
    };
  in {
    devenv.shells.default = {
      # https://devenv.sh/reference/options/
      packages = [nvim];

      enterShell = ''
        hello
      '';
    };
  };
}
