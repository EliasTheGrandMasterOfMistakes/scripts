#!/bin/bash

# S_asb_2023-03
# repopick -t S_asb_2023-03

# Charging animation
cd frameworks/base/
git cherry-pick 10a30bf4bbee8e98a742338ef89f0a414ff638b9
cd ../../

# PixelProps
cd frameworks/base/
git cherry-pick 9c542fb2323aae953d9957d320ba8ae1603aaafe
cd ../../

# Updater
cd vendor/lineage
git fetch https://github.com/LG-G6/android_vendor_lineage.git lineage-19.1
git cherry-pick 8246f8702827e7ca209e607dcc17cf4f1dba998f
cd ../../
