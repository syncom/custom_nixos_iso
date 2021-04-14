# Example of custom nixOS ISO build

Build custom nixOS ISO

```bash
curl -L https://nixos.org/nix/install | sh
git clone --depth 1 --branch syncom/v20.09-deterministic-mcopy-for-iso https://github.com/syncom/nixpkgs.git
export NIX_PATH=nixpkgs=`pwd`/nixpkgs
git clone https://github.com/syncom/custom_nixos_iso.git
cd custom_nixos_iso/
nix-build iso.nix
```
