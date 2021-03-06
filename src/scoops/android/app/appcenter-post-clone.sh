#!/usr/bin/env bash
#Place this script in project/android/app/
GOOGLE_JSON_FILE_PATH=$APPCENTER_SOURCE_DIRECTORY/src/scoops/android/app/google-services.json
CONFIG_FILE_PATH=$APPCENTER_SOURCE_DIRECTORY/src/scoops/tool/configuration_setup.dart
MAIN_DART_FILE_PATH=$APPCENTER_SOURCE_DIRECTORY/src/scoops/lib/main.dart

echo "------------Creating Google File...------------"

touch $GOOGLE_JSON_FILE_PATH

echo "------------Created Google File at $GOOGLE_JSON_FILE_PATH------------"

echo "------------Updating Google JSON Content...------------"

echo ${GOOGLE_JSON//'\'/} > $GOOGLE_JSON_FILE_PATH

echo "------------Google Service Json Updated!!------------"


# fail if any command fails
set -e
# debug log
set -x

cd ..
cd ..

git clone -b beta https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH

flutter channel stable
flutter doctor

echo "------------Installed flutter to `pwd`/flutter------------"

echo "------------Starting Flutter Configuration Task...------------"

dart run $CONFIG_FILE_PATH

echo "------------Flutter Configuration Task Completed!!------------"

echo "------------Starting Release APK Build...------------"
# build APK
# if you get "Execution failed for task ':app:lintVitalRelease'." error, uncomment next two lines
# flutter build apk --debug
# flutter build apk --profile

flutter build apk --release --build-number $APPCENTER_BUILD_ID

# if you need build bundle (AAB) in addition to your APK, uncomment line below and last line of this script.
#flutter build appbundle --release --build-number $APPCENTER_BUILD_ID

# copy the APK where AppCenter will find it
mkdir -p android/app/build/outputs/apk/; mv build/app/outputs/flutter-apk/app-release.apk $_

# copy the AAB where AppCenter will find it
#mkdir -p android/app/build/outputs/bundle/; mv build/app/outputs/bundle/release/app-release.aab $_

echo "------------Release APK Build Completed------------"