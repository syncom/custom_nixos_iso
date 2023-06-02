# Recipe for deterministic custom nixOS ISO builds

Build custom nixOS ISO (the ISO is "custom" in that it contains a custom package
named "hello_syncom")

```bash
curl -L https://nixos.org/nix/install | sh
git clone https://github.com/NixOS/nixpkgs.git
pushd nixpkgs
# This commit is tagged as 21.11 in nixpkgs, which includes the determinism
# improvement https://github.com/NixOS/nixpkgs/pull/119657
git checkout a7ecde854aee5c4c7cd6177f54a99d2c1ff28a31
popd
export NIX_PATH=nixpkgs=$(pwd)/nixpkgs
git clone https://github.com/syncom/custom_nixos_iso.git
cd custom_nixos_iso/
git checkout 817946610fd188a57c19e1983680cdaad3c35fa3
nix-build iso.nix
```

On three distinct Ubuntu (`x86_64-linux`) machines, and one NixOS VM
(corresponding to [this SHA256
digest](https://releases.nixos.org/nixos/20.09/nixos-20.09.4154.33824cdf8e4/nixos-20.09.4154.33824cdf8e4-x86_64-linux.ova.sha256))
the above procedures produced the same ISO for me.

```bash
# On one of the Ubuntu machines
$ uname -a
Linux syncom-xps13 5.4.0-126-generic #142~18.04.1-Ubuntu SMP Thu Sep 1 16:25:16 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
$ sha256sum $(readlink -f result)/iso/*.iso
5443e41acee9664e3b8dcc46e72bf54aec323457ec703aa7948d0c20f975ff5b  /nix/store/k4fa432jpfjs0wivi736dacs59jra466-nixos-21.11pre-git-x86_64-linux.iso/iso/nixos-21.11pre-git-x86_64-linux.iso
```

## Build ISO in Docker

The above deterministic ISO creation process can be automated using Docker.
Run the following command in the repository root directory.

```bash
make iso
```

When we make the ISO at revision
`817946610fd188a57c19e1983680cdaad3c35fa3`, text like that shown below
is expected in command output. The value for `IMAGE sha256sum` is
critical to check for reproducibility.

```text
============ CUSTOM NIXOS ISO INFO ============
ISO image created in /tmp/custom_nixos_iso/out/custom_nixos_iso-817946610fd188a57c19e1983680cdaad3c35fa3.iso
IMAGE sha256sum: 5443e41acee9664e3b8dcc46e72bf54aec323457ec703aa7948d0c20f975ff5b
```

## Clean up

Clean up built ISO

```bash
make clean
```

Prune Docker resources (to save disk space, for example)

```bash
make dockerclean
```

## References

I've learned from the following resources:

1. [Nix Pills](https://nixos.org/guides/nix-pills/), by Luca Bruno (aka
Lethalman).
2. [Managing private Nix packages outside the Nixpkgs
tree](http://sandervanderburg.blogspot.com/2014/07/managing-private-nix-packages-outside.html?m=1),
by Sander van der Burg.
3. [Creating a NixOS live
CD](https://nixos.wiki/wiki/Creating_a_NixOS_live_CD), on nixos.wiki.
4. Github project: [mbp-nixos](https://github.com/cstrahan/mbp-nixos), by
Charles Strahan (cstrahan).
5. [nixpkgs](https://github.com/NixOS/nixpkgs), nixpkgs source code.
