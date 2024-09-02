{
  pkgs,
  ruby-nix,
  bundix,
  ...
}:
let
  gemset = if builtins.pathExists ./gemset.nix then import ./gemset.nix else { };

  rubyNix = ruby-nix.lib pkgs {
    inherit gemset;

    ruby = pkgs.ruby_3_3;
    name = "rb_playground";
    gemConfig = pkgs.defaultGemConfig;
  };
in
{
  env.BUNDLE_PATH = "vendor/bundle";

  packages = [
    bundix.packages.${pkgs.stdenv.system}.default
    rubyNix.env
    rubyNix.ruby
    pkgs.git
  ];

  enterTest = "rake";

  devcontainer = {
    enable = true;
    settings.customizations.vscode.extensions = [
      "mkhl.direnv"
      "Shopify.ruby-extensions-pack"
    ];
  };
}
