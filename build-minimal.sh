#!/bin/sh

rm -rf output-debian-minimal-* 

packer build \
    --var-file="debian-builder.json" \
    --var-file="debian-minimal-version-11.5.0.json" \
    debian-minimal.json
    