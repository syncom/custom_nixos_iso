# The following information is from https://hub.docker.com/r/nixos/nix/tags
FROM nixos/nix:2.3.11@sha256:6903aa8484f625a304961ef9166ea89954421888f6a59af09893b17630225710 as image_builder

#########################################################
# Step 1: Prepare nixpkgs for deterministic builds
#########################################################
WORKDIR /build
# Note that this commit is tagged as 20.09 in nixpkgs
ENV NIXPKGS_COMMIT_SHA="cd63096d6d887d689543a0b97743d28995bc9bc3"

# Necessary patch for deterministic ISO build. This provides a workaround
# until https://github.com/NixOS/nixpkgs/pull/119657 is included in a stable
# nixpkgs release
COPY nixpkgs.patch /build/nixpkgs.patch

RUN nix-env -i git && \
    mkdir -p /build/nixpkgs && \
    cd nixpkgs && \
    git init && \
    git remote add origin https://github.com/NixOS/nixpkgs.git && \
    git fetch --depth 1 origin ${NIXPKGS_COMMIT_SHA} && \
    git checkout FETCH_HEAD && \
    git apply ../nixpkgs.patch && \
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
