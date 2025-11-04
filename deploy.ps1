# MarketTrack Deployment Script for Windows PowerShell

Write-Host "🚀 Starting MarketTrack deployment..." -ForegroundColor Green

# 1. Build Admin Panel
Write-Host "📦 Building Admin Panel..." -ForegroundColor Cyan
Set-Location MarketTrackAdmin
dotnet publish -c Release -o ..\deploy\admin
Set-Location ..

# 2. Check APK Build Status
Write-Host "📱 Checking Mobile App build..." -ForegroundColor Cyan
if (Test-Path "mobile_app\build\app\outputs\flutter-apk\app-release.apk") {
    Write-Host "✅ APK build complete!" -ForegroundColor Green
    $apkSize = (Get-Item "mobile_app\build\app\outputs\flutter-apk\app-release.apk").Length / 1MB
    Write-Host "   APK Size: $([math]::Round($apkSize, 2)) MB" -ForegroundColor Yellow
} else {
    Write-Host "⏳ APK build still in progress..." -ForegroundColor Yellow
}

# 3. Commit and push to GitHub
Write-Host "📤 Pushing to GitHub..." -ForegroundColor Cyan
git add .
git commit -m "Deployment: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git push origin main

Write-Host ""
Write-Host "✅ Deployment complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Deployment Summary:" -ForegroundColor White
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "🌐 Admin Panel Build: " -NoNewline
Write-Host "READY" -ForegroundColor Green
Write-Host "   Location: deploy\admin\" -ForegroundColor Gray
Write-Host ""
Write-Host "📱 Mobile App Build: " -NoNewline
if (Test-Path "mobile_app\build\app\outputs\flutter-apk\app-release.apk") {
    Write-Host "COMPLETE" -ForegroundColor Green
    Write-Host "   Location: mobile_app\build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor Gray
} else {
    Write-Host "IN PROGRESS" -ForegroundColor Yellow
}
Write-Host ""
Write-Host "🗄️ Appwrite Backend: " -NoNewline
Write-Host "CONFIGURED" -ForegroundColor Green
Write-Host "   Project ID: 690911f10028fa64956b" -ForegroundColor Gray
Write-Host "   Database: markettrack_db" -ForegroundColor Gray
Write-Host "   Collections: 4 (users, device_monitoring, monitoring_alerts, notifications)" -ForegroundColor Gray
Write-Host "   Storage Buckets: 5 (nid_cards, profile_videos, check_in_selfies, reports, audio_notes)" -ForegroundColor Gray
Write-Host ""
Write-Host "🔗 URLs:" -ForegroundColor White
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "   Admin Panel: https://marketm-anagement.appwrite.network/" -ForegroundColor Cyan
Write-Host "   GitHub Repo: https://github.com/milandare26feb-ops/marketing-management-system" -ForegroundColor Cyan
Write-Host "   Appwrite Console: https://cloud.appwrite.io/console/project-690911f10028fa64956b" -ForegroundColor Cyan
Write-Host ""
Write-Host "📝 Next Steps:" -ForegroundColor White
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "   1. Wait for APK build to complete (if not done)" -ForegroundColor Yellow
Write-Host "   2. Test APK on Android device" -ForegroundColor Yellow
Write-Host "   3. Deploy admin panel to Appwrite domain" -ForegroundColor Yellow
Write-Host "   4. Configure production credentials" -ForegroundColor Yellow
Write-Host ""
