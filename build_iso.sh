#!/usr/bin/env bash

set -euxo pipefail

SCRIPT_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
OUT_DIR="${SCRIPT_DIR}/out"
REVISION=$(git --work-tree="${SCRIPT_DIR}/" \
  --git-dir="${SCRIPT_DIR}/.git" \
  rev-parse HEAD)
IN_ISO_NAME="nixos-23.05pre-git-x86_64-linux.iso"
OUT_ISO_NAME="custom_nixos_iso-${REVISION}.iso"
BUILDER_TAG_NAME="nixos-builder:$REVISION"

echo "Building custom ISO image"
cd "${SCRIPT_DIR}"
docker build --platform linux/amd64 -f "${SCRIPT_DIR}/Dockerfile" -t "${BUILDER_TAG_NAME}" .
docker images "${BUILDER_TAG_NAME}"
mkdir -p "${OUT_DIR}"

docker run --platform linux/amd64 --entrypoint=/bin/sh --rm -i -v "${OUT_DIR}":/tmp/ \
  "${BUILDER_TAG_NAME}" << CMD
cp -Lr "/build/result/iso/${IN_ISO_NAME}" "/tmp/${OUT_ISO_NAME}"
CMD

echo
echo "============ CUSTOM NIXOS ISO INFO ============"
echo "ISO image created in ${OUT_DIR}/${OUT_ISO_NAME}"
echo -n "IMAGE sha256sum: "
shasum -a 256 "${OUT_DIR}/${OUT_ISO_NAME}" | cut -f1 -d' '
echo
