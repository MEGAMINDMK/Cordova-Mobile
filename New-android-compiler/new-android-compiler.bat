@echo off
::Make sure you have app-release-unsigned.apk inside apk folder
cd apk-signer-verify
java -jar apk-signer-verify.jar -a apk/app-release-unsigned.apk --out release
cd ../apk-signer-verify/release
set /P appname="Enter Name Of app name: "
ren app-release-aligned-debugSigned.apk %appname%.apk