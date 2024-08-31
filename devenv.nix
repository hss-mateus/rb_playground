{ pkgs, ... }:
{
  env.NIX_LD = "${pkgs.glibc}/lib64/ld-linux-x86-64.so.2";

  packages = with pkgs; [
    cmake
    editorconfig-core-c
    git
    libyaml
    openssl
    readline
    watchman
  ];

  languages.ruby = {
    enable = true;
    bundler.enable = false;
    package = pkgs.ruby_3_3;
  };

  enterShell = "bundle check || bundle install";
  enterTest = "bundle exec rake";

  devcontainer = {
    enable = true;
    settings.customizations.vscode.extensions = [
      "mkhl.direnv"
      "Shopify.ruby-extensions-pack"
    ];
  };
}
