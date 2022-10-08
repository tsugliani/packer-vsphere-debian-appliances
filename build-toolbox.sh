#!/bin/sh

rm -rf output-debian-toolbox-*

packer build \
    --var-file="debian-builder.json" \
    --var-file="debian-toolbox-version-11.5.0.json" \
    debian-toolbox.json
