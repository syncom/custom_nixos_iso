# Example of custom nixOS ISO build

Build custom nixOS ISO

```bash
curl -L https://nixos.org/nix/install | sh
git clone --depth 1 --branch syncom/v20.09-deterministic-mcopy-for-iso https://github.com/syncom/nixpkgs.git
export NIX_PATH=nixpkgs=`pwd`/nixpkgs
git clone https://github.com/syncom/custom_nixos_iso.git
cd custom_nixos_iso/
git checkout b33fee2ae3eae23511692b6c031fab359ef0e773
nix-build iso.nix
```

On three distinct Ubuntu (`x86_64-linux`) machines, the above procedures produced the same ISO for me.

```bash
$ sha256sum result/iso/nixos-20.09pre-git-x86_64-linux.iso
ac64b0cd12715a762b713f403b628141cf29445a8ede9b703910377b5b1f53cb  result/iso/nixos-20.09pre-git-x86_64-linux.iso
```
