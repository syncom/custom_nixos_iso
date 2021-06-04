# Example of deterministic custom nixOS ISO build

Build custom nixOS ISO

```bash
curl -L https://nixos.org/nix/install | sh
git clone --depth 1 --branch syncom/deterministic-efiimg https://github.com/syncom/nixpkgs.git
pushd nixpkgs
git checkout 657e924ad853e099cbc36be50478e9877aa05a25
popd
export NIX_PATH=nixpkgs=`pwd`/nixpkgs
git clone https://github.com/syncom/custom_nixos_iso.git
cd custom_nixos_iso/
git checkout b33fee2ae3eae23511692b6c031fab359ef0e773
nix-build iso.nix
```

On three distinct Ubuntu (`x86_64-linux`) machines, and one NixOS VM
(corresponding to [this SHA256
digest](https://releases.nixos.org/nixos/20.09/nixos-20.09.4154.33824cdf8e4/nixos-20.09.4154.33824cdf8e4-x86_64-linux.ova.sha256))
the above procedures produced the same ISO for me.

```bash
# On one of the Ubuntu machines
$ uname -a
Linux syncom-cyberpower 5.4.0-73-generic #82~18.04.1-Ubuntu SMP Fri Apr 16 15:10:02 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
$ sha256sum $(readlink -f result)/iso/nixos-21.05pre-git-x86_64-linux.iso
10b295f5126f990133cd97879d59c75354a8b86c912c77d0475c9c3ce8287ef8  /nix/store/avs706g4s16c7x0m3c2z99ix6l6v1l6a-nixos-21.05pre-git-x86_64-linux.iso/iso/nixos-21.05pre-git-x86_64-linux.iso
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
