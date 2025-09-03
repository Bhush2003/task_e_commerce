@echo off
echo Running Flutter commands...
echo.

echo 1. Getting Flutter packages...
flutter pub get

echo.
echo 2. Running build runner to generate Hive adapters...
flutter packages pub run build_runner build

echo.
echo 3. Build runner completed!
pause


