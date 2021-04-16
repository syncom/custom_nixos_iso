# Example of custom nixOS ISO build

Build custom nixOS ISO

```bash
curl -L https://nixos.org/nix/install | sh
git clone --depth 1 --branch syncom/deterministic-efiimg https://github.com/syncom/nixpkgs.git
pushd nixpkgs
git checkout e1cb2fe4fce8d57e39b0b92e1b8dfe174ba57b72
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
$ sha256sum result/iso/nixos-21.05pre-git-x86_64-linux.iso
7be15e8843cc3e37021964e4489d06847aaa4a55659af0ce444d8de817adb00b  result/iso/nixos-21.05pre-git-x86_64-linux.iso
```
