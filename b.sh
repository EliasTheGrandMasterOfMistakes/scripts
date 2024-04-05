#!/bin/bash

 type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y

mkdir -p workspace && cd workspace
  git clone --depth=1 https://github.com/Jiovanni-dump/xiaomi_ishtar_dump -b missi_phone_global-user-13-TKQ1.221114.001-V14.0.1.0.TMAMIXM-release-keys ./firmware-dump

  git clone --depth=1 https://github.com/HurtCopain/device_xiaomi_sm8550-common -b lineage-20 ./android/device/xiaomi/sm8550-common


  git clone --depth=1 https://github.com/LineageOS/android_tools_extract-utils -b lineage-20.0 ./android/tools/extract-utils
  echo "Done cloning extract-utils."
  git clone --depth=1  https://github.com/LineageOS/android_prebuilts_extract-tools -b lineage-20.0 ./android/prebuilts/extract-tools
  echo "Done cloning extract-tools."


  chmod a+x android/device/xiaomi/sm8550-common/setup-makefiles.sh
  cd android/device/xiaomi/sm8550-common
  bash extract-files.sh ../../../../firmware-dump/
  echo "Done extracting and making files."
  echo "Pushing as repository now."