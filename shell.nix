{ nixpkgs ? import <nixpkgs> { }, compiler ? "default" }:
let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, stdenv, base, Cabal, cabal-install, lens }:
    mkDerivation {
      pname = "idiom";
      version = "0.0.0.1";
      src = ./.;
      isLibrary = false;
      isExecutable = true;
      executableSystemDepends = [ ];
      executableHaskellDepends = [ base Cabal cabal-install lens ];
      homepage = "https://gitlab.com/karetsu/distances";
      description =
        "A haskell package for evaluating distances (metrics) between points";
      license = stdenv.lib.licenses.mit;
    };

  haskellPackages = if compiler == "default" then
    pkgs.haskellPackages
  else
    pkgs.haskell.packages.${compiler};

  drv = pkgs.lib.id (haskellPackages.callPackage f { });
in if pkgs.lib.inNixShell then drv.env else drv
