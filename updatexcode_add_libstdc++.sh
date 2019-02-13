#!/bin/bash
platforms_array=("AppleTVOS" "AppleTVSimulator" "iPhoneOS" "iPhoneSimulator" "MacOSX" "WatchOS" "WatchSimulator");

echo "需要使用sudo命令调用此脚本。 Use sudo command";
echo "example:"
echo "          sudo ./updatexcode_add_libstdc++.sh"

echo "Confirm your Xcode.app file name&path"
echo "调用脚本前请确认 Xcode.app的文件名及路径"

XCODE_APP_PATH="/Applications/Xcode.app";
PLATFORMS_PATH=$XCODE_APP_PATH"/Contents/Developer/Platforms/";
REPO="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_PATH=$REPO
SOURCE_INCLUDE_CPP=$SOURCE_PATH"/c++";
SOURCE_LIB_STDCPP=$SOURCE_PATH"/libstdc++.6.0.9.tbd";

for platform in ${platforms_array[@]}
do
  echo "处理："${platform}
  TARGET_SDK_PATH=${PLATFORMS_PATH}${platform}".platform/Developer/SDKs/"${platform}".sdk";
  echo "path:"${TARGET_SDK_PATH}

  TARGET_SDK_INCLUDE=$TARGET_SDK_PATH"/usr/include";
  TARGET_SDK_LIB=$TARGET_SDK_PATH"/usr/lib";
  TARGET_SDK_INCLUDE_CPP=$TARGET_SDK_INCLUDE"/c++";
  TARGET_SDK_LIB_STDCPP=$TARGET_SDK_LIB"/libstdc++.tbd";
  TARGET_SDK_LIB_STDCPP_6=$TARGET_SDK_LIB"/libstdc++.6.tbd";
  TARGET_SDK_LIB_STDCPP_609=$TARGET_SDK_LIB"/libstdc++.6.0.9.tbd";

  echo "link c++"
  ln -s $SOURCE_INCLUDE_CPP $TARGET_SDK_INCLUDE_CPP

  echo "link libstdc++.tbd"
  ln -s $SOURCE_LIB_STDCPP $TARGET_SDK_LIB_STDCPP

  echo "link libstdc++.6.tbd"
  ln -s $SOURCE_LIB_STDCPP $TARGET_SDK_LIB_STDCPP_6

  echo "link libstdc++.6.0.9.tbd"
  ln -s $SOURCE_LIB_STDCPP $TARGET_SDK_LIB_STDCPP_609
done
echo "finish!"
