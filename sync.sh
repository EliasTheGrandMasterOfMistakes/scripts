#!/bin/bash
rm -rf .repo/local_manifests hardware/lge
mkdir .repo/local_manifests
cp scripts/roomservice.xml .repo/local_manifests
mv scripts/statix.xml .repo/manifests/snippets
repo sync -c -j16 --force-sync --no-clone-bundle --no-tags
source build/envsetup.sh
#m cleanfdsfdsf
#make clean

 rm out/target/product/*/*.zip
# source scripts/fixes.sh
#source build/envsetup.sh && lunch evolution_h872-eng && (while true; do clear; ccache -s; sleep 60; done) & m -j$(nproc --all) evolution

source build/envsetup.sh
lunch cipher_h872-eng

m -j$(nproc --all) bacon
