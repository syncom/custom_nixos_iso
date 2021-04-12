{nixpkgs ? <nixpkgs>, system ? "x86_64-linux"}:

let 
hello_syncom = (import ./custom_configuration.nix {}).hello_syncom;

syncomisoconfig = {config, pkgs, ...}:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  isoImage.includeSystemBuildDependencies = false;
  isoImage.storeContents = with pkgs; [
    bash
    git
    (python38.withPackages(p: with p; [ protobuf ]))
    cmake
    gnumake
    binutils
    protobuf
    clang-tools
    gcc
    patchelf
    hello_syncom
  ];

  # programs that should be available in the installer
  environment.systemPackages = with pkgs; [
    bash
    git
    (python38.withPackages(p: with p; [ protobuf ]))
    cmake
    gnumake
    binutils
    protobuf
    clang-tools
    gcc
    patchelf
  ];
};

  evalNixos = configuration: import "${nixpkgs}/nixos/default.nix" {
    inherit system configuration;
  };
in { iso = (evalNixos syncomisoconfig).config.system.build.isoImage; }
