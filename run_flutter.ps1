Write-Host "Running Flutter commands..." -ForegroundColor Green
Write-Host ""

Write-Host "1. Getting Flutter packages..." -ForegroundColor Yellow
& flutter pub get

Write-Host ""
Write-Host "2. Running build runner to generate Hive adapters..." -ForegroundColor Yellow
& flutter packages pub run build_runner build

Write-Host ""
Write-Host "3. Build runner completed!" -ForegroundColor Green
Read-Host "Press Enter to continue"


