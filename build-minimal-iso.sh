#!/bin/sh

rm -rf output-debian-minimal-* 

packer build \
    --var-file="debian-minimal-iso-version-11.4.0.json" \
    debian-minimal-iso.json
    