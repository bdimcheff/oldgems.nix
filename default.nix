# run this with nix-shell --pure
# ruby --version will give you 1.8.7, as expected
# gem --version will give you 2.4.x, not 1.8.30

with import <nixpkgs> {
  config.packageOverrides = pkgs: {
    ruby = pkgs.ruby_1_8;
    mygems = pkgs.stdenv.lib.overrideDerivation pkgs.rubygems ( oldAttrs: {
      name = "rubygems-1.8.30";
      src = pkgs.fetchurl {
        url = "https://github.com/rubygems/rubygems/releases/download/v1.8.30/rubygems-1.8.30.tgz";
        sha256 = "073jcw3a4ym83708ka15gxvaaf07fmkz2jil1fcknhb7rzrqkw1z";
      };
    });
  };
}; {
  oldGemEnv = stdenv.mkDerivation rec {
    name = "oldgems";

    buildInputs = [
      ruby
      mygems
    ];
  };
}
