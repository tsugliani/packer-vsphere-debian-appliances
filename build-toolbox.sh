#!/bin/sh

packer build \
    --var-file="debian-builder.json" \
    --var-file="debian-toolbox-version-10.9.0.json" \
    debian-toolbox.json
