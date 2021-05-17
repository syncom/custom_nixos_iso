# Example of custom nixOS ISO build

Build custom nixOS ISO

```bash
curl -L https://nixos.org/nix/install | sh
git clone --depth 1 --branch syncom/deterministic-efiimg https://github.com/syncom/nixpkgs.git
pushd nixpkgs
git checkout e3cd6444584dc2d018a39ad7f94769caf043e621
popd
export NIX_PATH=nixpkgs=`pwd`/nixpkgs
git clone https://github.com/syncom/custom_nixos_iso.git
cd custom_nixos_iso/
git checkout b33fee2ae3eae23511692b6c031fab359ef0e773
nix-build iso.nix
```

On three distinct Ubuntu (`x86_64-linux`) machines, the above procedures
produced the same ISO for me.

```bash
$ readlink -f result
/nix/store/zpiscj1x68asg55zc9gbl2x5kz4hrg9a-nixos-21.05pre-git-x86_64-linux.iso
$ sha256sum result/iso/nixos-21.05pre-git-x86_64-linux.iso
280e7ca8091744cebc38b49e69935f9c25b3e5fb7326eaedf0a21daf4736f445  result/iso/nixos-21.05pre-git-x86_64-linux.iso
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
