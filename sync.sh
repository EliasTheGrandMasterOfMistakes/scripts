#!/bin/bash
rm -rf .repo/local_manifests
#rm -rf .repo/manifests/snippets/lineage.xml
#cp scripts/lineage.xml .repo/manifests/snippets

#rm -rf .repo/manifests/default.xml
#cp scripts/default.xml .repo/manifests
#rm -rf .repo/manifests/snippets/extra.xml
#cp scripts/extra.xml .repo/manifests/snippets


rm -rf .repo/manifests/snippets/derp.xml
cp scripts/derp.xml .repo/manifests/snippets
mkdir .repo/local_manifests
cp scripts/roomservice.xml .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
source build/envsetup.sh
#mka clean
#make clean
rm out/target/product/*/*.zip
#source scripts/fixes.sh
lunch derp_h872-userdebug
mka -j$(nproc --all) derp
#lunch lineage_us997-userdebug
#m -j$(nproc --all) bacon
#lunch lineage_h870-userdebug
#m -j$(nproc --all) bacon
