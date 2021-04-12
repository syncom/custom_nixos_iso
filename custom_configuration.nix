{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> {inherit system; };

  callPackage = pkgs.lib.callPackageWith (pkgs // self);

  self = {
    hello_syncom = callPackage ./pkgs/hello_syncom {};
  };
in self
