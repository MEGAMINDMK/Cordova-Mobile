@echo off

:: ============================================================
:: Cordova USB Environment Setup
:: ============================================================

set "CORDOVA_ROOT=%~dp0"
set "CORDOVA_ROOT=%CORDOVA_ROOT:~0,-1%"

echo.
echo ==========================================
echo       Cordova USB Environment
echo ==========================================
echo.
echo Cordova folder:
echo %CORDOVA_ROOT%
echo.

:: ------------------------------------------------------------
:: Cordova paths
:: ------------------------------------------------------------

set "JAVA_HOME=%CORDOVA_ROOT%\Java\jdk-17"
set "ANDROID_HOME=%CORDOVA_ROOT%\Android\android-sdk"
set "ANDROID_SDK_ROOT=%CORDOVA_ROOT%\Android\android-sdk"
set "GRADLE_HOME=%CORDOVA_ROOT%\gradle-8.11.1"

:: ------------------------------------------------------------
:: Verify folders
:: ------------------------------------------------------------

if not exist "%JAVA_HOME%\bin\java.exe" (
    echo ERROR: Java not found:
    echo %JAVA_HOME%
    pause
    exit /b 1
)

if not exist "%ANDROID_HOME%" (
    echo ERROR: Android SDK not found:
    echo %ANDROID_HOME%
    pause
    exit /b 1
)

if not exist "%GRADLE_HOME%\bin\gradle.bat" (
    echo ERROR: Gradle not found:
    echo %GRADLE_HOME%
    pause
    exit /b 1
)

:: ------------------------------------------------------------
:: IMPORTANT
:: Keep Windows system paths explicitly available.
:: USB paths go FIRST.
:: ------------------------------------------------------------

set "PATH=%JAVA_HOME%\bin;%GRADLE_HOME%\bin;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\cmdline-tools\latest\bin;C:\Windows\System32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\nodejs;C:\Users\muhom\AppData\Roaming\npm;%PATH%"
:: ------------------------------------------------------------
:: Android variables
:: ------------------------------------------------------------

set "ANDROID_SDK_BUILDTOOLS=%ANDROID_HOME%\build-tools\29.0.3"
set "ANDROID_SDK_PLATFORMTOOLS=%ANDROID_HOME%\platform-tools"
set "ANDROID_SDK_TOOLS=%ANDROID_HOME%\tools"

:: ------------------------------------------------------------
:: Show configuration
:: ------------------------------------------------------------

echo.
echo ==========================================
echo Environment configured successfully
echo ==========================================
echo.

echo Java:
echo %JAVA_HOME%
echo.

echo Android SDK:
echo %ANDROID_HOME%
echo.

echo Gradle:
echo %GRADLE_HOME%
echo.

echo ==========================================
echo Testing Java
echo ==========================================
java -version

echo.
echo ==========================================
echo Testing Gradle
echo ==========================================
where gradle
gradle -version

echo.
echo ==========================================
echo Testing ADB
echo ==========================================
where adb
adb version

echo.
echo ==========================================
echo Testing Cordova
echo ==========================================
where cordova
cordova -v

echo.
echo ==========================================
echo Cordova USB environment is READY!
echo ==========================================
echo.

cmd /k