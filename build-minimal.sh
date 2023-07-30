#!/bin/sh

rm -rf output-debian-minimal-*

packer build \
    --var-file="debian-builder.json" \
    --var-file="debian-minimal-version-12.1.0.json" \
    debian-minimal.json
