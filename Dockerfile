# The following information is from https://hub.docker.com/r/nixos/nix/tags
FROM nixos/nix:2.9.0@sha256:13b257cd42db29dc851f9818ea1bc2f9c7128c51fdf000971fa6058c66fbe4b6 as image_builder

#########################################################
# Step 1: Prepare nixpkgs for deterministic builds
#########################################################
WORKDIR /build
# Note that this commit is tagged as 23.05 in nixpkgs, which
# includes the determinism improvement
# https://github.com/NixOS/nixpkgs/pull/119657
ENV NIXPKGS_COMMIT_SHA="4ecab3273592f27479a583fb6d975d4aba3486fe"

# Apple M1 workaround
COPY nix.conf /build/nix.conf
ENV NIX_USER_CONF_FILES=/build/nix.conf

RUN nix-env -i git && \
    mkdir -p /build/nixpkgs && \
    cd nixpkgs && \
    git init && \
    git remote add origin https://github.com/NixOS/nixpkgs.git && \
    git fetch --depth 1 origin ${NIXPKGS_COMMIT_SHA} && \
    git checkout FETCH_HEAD && \
    cd ../

ENV NIX_PATH=nixpkgs=/build/nixpkgs

#########################################################
# Step 2: Build docker image
#########################################################
COPY pkgs/ /build/pkgs
COPY custom_configuration.nix /build/custom_configuration.nix
COPY iso.nix /build/iso.nix

# Build final artifact
RUN nix-build iso.nix
