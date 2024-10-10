{
  pkgs,
  ruby-nix,
  bundix,
  ...
}:
with pkgs;
let
  rubyNix = ruby-nix.lib pkgs {
    gemset = ./gemset.nix;
    ruby = ruby_3_3;
    gemConfig = defaultGemConfig;
  };
in
{
  packages = [
    bundix.packages.${system}.default
    editorconfig-core-c
    git
    rubyNix.env
  ];

  env.RUBY_YJIT_ENABLE = 1;
  enterTest = "rake";
  cachix.enable = false;

  devcontainer = {
    enable = true;
    settings.customizations.vscode.extensions = [
      "mkhl.direnv"
      "Shopify.ruby-extensions-pack"
    ];
  };
}
