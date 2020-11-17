:: ANDROID BROWSER COMPILER STARTS
:: Make sure to change you project path / folder name at line 27,34,42,50,56
@ECHO off
title Android Compiler
cls
:start
ECHO 1. Compile Debug
ECHO 2. Compile Release
ECHO 3. Sign Release
ECHO 4. Open Debug
ECHO 5. Open Release
ECHO 6. Open Compressors
set choice=
set /p choice=Enter Option:
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto Compile_Debug
if '%choice%'=='2' goto Compile_Release
if '%choice%'=='3' goto Sign_Release
if '%choice%'=='4' goto Open_Debug
if '%choice%'=='5' goto Open_Release
if '%choice%'=='6' goto Open_Compressors
ECHO "%choice%" is not valid, try again
goto start
:Compile_Debug
ECHO Compile Debug
title Compile APK
set folderpath=android_webnet
cd %folderpath%
cordova build android
goto end
:Compile_Release
ECHO Compile Release
title Compile APK
set folderpath=android_webnet
cd %folderpath%
cordova build --release android
goto end
:Sign_Release
ECHO Sign Release
title Compile APK Certificate (License)
set folderpath=android_webnet
cd %folderpath%\platforms\android\app\build\outputs\apk\release
set alias=android
keytool -genkey -v -keystore %alias%.keystore -alias %alias% -keyalg RSA -keysize 2048 -validity 10000
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore %alias%.keystore app-release-unsigned.apk %alias%
set /P appname="Enter Name Of app name: "
start C:\cordova\Android\android-sdk\build-tools\29.0.3\zipalign -v 4 app-release-unsigned.apk %appname%.apk
goto end
:Open_Debug
ECHO Open Debug
set folderpath=android_webnet
start %folderpath%\platforms\android\app\build\outputs\apk\debug
goto end
:Open_Release
ECHO Open Release
set folderpath=android_webnet
start %folderpath%\platforms\android\app\build\outputs\apk\release
goto end
:Open_Compressors
ECHO Open Compressors
title Webnet Official App Compressors
start https://imagecompressor.com/
start https://htmlcompressor.com/
start https://csscompressor.com/
start https://javascript-compressor.com/
goto end
:end
:: Webnet Official ANDROID BROWSER COMPILER ENDS



