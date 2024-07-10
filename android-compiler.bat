@ECHO off
title Webnet Official Compiler
cls
:: Webnet Official BROWSER COMPILER CHOICES
:start
ECHO 1. PC
ECHO 2. Android
set choice=
set /p choice=Enter Option: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto PC
if '%choice%'=='2' goto Android
ECHO "%choice%" is not valid, try again
goto start

:: Webnet Official PC BROWSER COMPILER STARTS
:PC
@ECHO off
title Webnet Official PC Compiler
cls
:startPC
ECHO 1. Compile
ECHO 2. Build
set choice=
set /p choice=Enter Option: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto Compile
if '%choice%'=='2' goto Build
ECHO "%choice%" is not valid, try again
goto startPC

:Compile
ECHO Compile 
title Compile Webnet EXE
cd official
npm run package-win
npm run package-mac
goto end

:Build
ECHO Build
title Compile Webnet EXE
node build.js
goto end

:: Webnet Official PC BROWSER COMPILER ENDS
:: Webnet Official ANDROID BROWSER COMPILER STARTS
:Android
@ECHO off
title Webnet Official Android Compiler
cls
:startAndroid
ECHO 1. Compile Debug
ECHO 2. Compile Release
ECHO 3. Sign Self Release
ECHO 4. Sign Original Release
ECHO 5. Open Debug
ECHO 6. Open Old Release
ECHO 7. Open New Release
ECHO 8. Open Compressors
ECHO 9. Compile aab for Google
ECHO a. Aab sign for Google
ECHO b. Open aab
set choice=
set /p choice=Enter Option: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto Compile_Debug
if '%choice%'=='2' goto Compile_Release
if '%choice%'=='3' goto SignSelf_Release
if '%choice%'=='4' goto SignOriginal_Release
if '%choice%'=='5' goto Open_Debug
if '%choice%'=='6' goto Open_Old_Release
if '%choice%'=='7' goto Open_New_Release
if '%choice%'=='8' goto Open_Compressors
if '%choice%'=='9' goto Compile_aab
if '%choice%'=='a' goto aab_sign
if '%choice%'=='b' goto open_aab
ECHO "%choice%" is not valid, try again
goto startAndroid

:Compile_Debug
ECHO Compile Debug
title Compile Webnet APK
cd android_webnet
cordova build android
goto end

:Compile_Release
ECHO Compile Release
title Compile Webnet APK
cd android_webnet
cordova clean && npm prune && cordova build android --release -- --packageType=apk
goto end

:SignSelf_Release
ECHO Sign Self Release
title Compile Webnet APK Certificate (License)
cd android_webnet\platforms\android\app\build\outputs\apk\release
C:\cordova\Java\jdk1.8\bin\keytool -genkey -v -keystore webnet.keystore -alias webnet -keyalg RSA -keysize 2048 -validity 10000
C:\cordova\Java\jdk1.8\bin\jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore webnet.keystore app-release-unsigned.apk webnet
C:\cordova\Java\jdk1.8\bin\jarsigner -verify -verbose -certs app-release-unsigned.apk
set /P appname="Enter Name Of app name: "
start C:\cordova\Android\android-sdk\build-tools\29.0.3\zipalign -v 4 app-release-unsigned.apk %appname%.apk
goto end

:SignOriginal_Release
ECHO Sign Original Release
title Compile Webnet APK Certificate (License)
cd android_webnet\platforms\android\app\build\outputs\apk\release
set Dest_Folder=F:\fm\main\apk-signer-verify\apk
copy app-release-unsigned.apk %Dest_Folder%\.
cd F:\fm\main\apk-signer-verify
java -jar apk-signer-verify.jar -a apk/app-release-unsigned.apk --out release
cd ../apk-signer-verify/release
set /P appname="Enter Name Of app name: "
ren app-release-aligned-debugSigned.apk %appname%.apk
TIMEOUT 5 /nobreak > nul
del "F:\fm\main\android_webnet\platforms\android\app\build\outputs\apk\release\app-release-unsigned.apk"
del "F:\fm\main\android_webnet\platforms\android\app\build\outputs\apk\release\output.json"
del "F:\fm\main\apk-signer-verify\apk\app-release-unsigned.apk"
del "F:\fm\main\apk-signer-verify\release\app-release-aligned-debugSigned.apk"
goto end

:Open_Debug
ECHO Open Debug
start android_webnet\platforms\android\app\build\outputs\apk\debug
goto end

:Open_Old_Release
ECHO Open Release
start android_webnet\platforms\android\app\build\outputs\apk\release
goto end

:Open_New_Release
ECHO Open Release
start F:\fm\main\apk-signer-verify\release
goto end

:Open_Compressors
ECHO Open Compressors
title Webnet Official App Compressors
start https://imagecompressor.com/
start https://htmlcompressor.com/
start https://csscompressor.com/
start https://javascript-compressor.com/
goto end

:Compile_aab
ECHO Compiling App to AAB
title Webnet Official App AAB
cd android_webnet
cordova clean && npm prune && cordova build android --release -- --packageType=bundle
goto end

:aab_sign
ECHO AAB Signing
title AAB Signing
cd android_webnet
cordova clean && npm prune && cordova build android --release -- --keystore=webnet.keystore --storePassword=pakarmy --alias=webnet --password=pakarmy --packageType=bundle --webpack.mode=production
goto end

:open_aab
start F:\fm\main\android_webnet\platforms\android\app\build\outputs\bundle\release
goto end

:end
:: Webnet Official ANDROID BROWSER COMPILER ENDS
