#!/usr/bin/env bash
#Place this script in project/android/app/




GOOGLE_JSON_FILE=$APPCENTER_SOURCE_DIRECTORY/src/scoops/android/android/app/google-services.json

echo $GOOGLE_JSON_FILE

if [ -f "$GOOGLE_JSON_FILE" ]
then 
    echo "$GOOGLE_JSON" > "$GOOGLE_JSON_FILE"
else
    echo "Warning !!!  file not found"
fi


google_json_content = cat $GOOGLE_JSON_FILE;

echo google_json_content

# if [ -e "$GOOGLE_JSON_FILE" ]
# then
#     echo "Updating Google Json"
#     echo "$GOOGLE_JSON" > $GOOGLE_JSON_FILE
#     sed -i -e 's/\\"/'\"'/g' $GOOGLE_JSON_FILE

#     echo "File content:"
#     cat $GOOGLE_JSON_FILE
# else

#     echo "Creating Google Json"

# fi




# fail if any command fails
set -e
# debug log
set -x

cd ..
git clone -b beta https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH

flutter channel stable
flutter doctor

echo "Installed flutter to `pwd`/flutter"


echo "Run Configuration Task"
dart run tool/configuration_setup.dart

echo "Config File:"

echo "$(<lib/core/infrastructure/env.dart )" 


# build APK
# if you get "Execution failed for task ':app:lintVitalRelease'." error, uncomment next two lines
# flutter build apk --debug
# flutter build apk --profile

flutter build apk --release

# if you need build bundle (AAB) in addition to your APK, uncomment line below and last line of this script.
#flutter build appbundle --release --build-number $APPCENTER_BUILD_ID

# copy the APK where AppCenter will find it
mkdir -p android/app/build/outputs/apk/; mv build/app/outputs/apk/release/app-release.apk $_

# copy the AAB where AppCenter will find it
#mkdir -p android/app/build/outputs/bundle/; mv build/app/outputs/bundle/release/app-release.aab $_