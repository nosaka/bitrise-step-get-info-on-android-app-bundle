#!/bin/bash
set -ex

readonly BUNDLE_TOOL="$BITRISE_STEP_SOURCE_DIR/tools/bundletool"

if [ ! -f "${aab_path}" ] ; then
  echo " [!] File doesn't exist at specified Android App Bundle (.aab) path: ${aab_path}"
  exit 1
fi

echo "Extrating version name and version code"
ANDROID_VERSION_NAME=`$BUNDLE_TOOL dump manifest --bundle $aab_path --xpath /manifest/@android:versionName`
ANDROID_VERSION_CODE=`$BUNDLE_TOOL dump manifest --bundle $aab_path --xpath /manifest/@android:versionCode`
ANDROID_PACKAGE_NAME=`$BUNDLE_TOOL dump manifest --bundle $aab_path --xpath /manifest/@package`
ANDROID_MIN_SDK_VERSION=`$BUNDLE_TOOL dump manifest --bundle $aab_path --xpath /manifest/uses-sdk/@android:minSdkVersion`
ANDROID_TARGET_SDK_VERSION=`$BUNDLE_TOOL dump manifest --bundle $aab_path --xpath /manifest/uses-sdk/@android:targetSdkVersion`

echo "ANDROID_VERSION_NAME:=${ANDROID_VERSION_NAME}"
echo "ANDROID_VERSION_CODE:=${ANDROID_VERSION_CODE}"
echo "ANDROID_PACKAGE_NAME:=${ANDROID_PACKAGE_NAME}"
echo "ANDROID_MIN_SDK_VERSION:=${ANDROID_MIN_SDK_VERSION}"
echo "ANDROID_TARGET_SDK_VERSION:=${ANDROID_TARGET_SDK_VERSION}"

envman add --key ANDROID_VERSION_NAME --value $ANDROID_VERSION_NAME
envman add --key ANDROID_VERSION_CODE --value $ANDROID_VERSION_CODE
envman add --key ANDROID_PACKAGE_NAME --value $ANDROID_PACKAGE_NAME
envman add --key ANDROID_MIN_SDK_VERSION --value $ANDROID_MIN_SDK_VERSION
envman add --key ANDROID_TARGET_SDK_VERSION --value $ANDROID_TARGET_SDK_VERSION
