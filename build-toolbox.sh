#!/bin/sh

rm -rf output-debian-toolbox-*

packer build \
    --var-file="debian-builder.json" \
    --var-file="debian-toolbox-version-12.1.0.json" \
    debian-toolbox.json
