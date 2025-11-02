@echo off
REM ================================================
REM  Git Push Script with Authentication
REM  MarketTrack Mobile App
REM ================================================

echo.
echo ===============================================
echo   Pushing to GitHub
echo   MarketTrack Mobile App
echo ===============================================
echo.

cd /d D:\MARKET_MANAGEMENT

REM Check Git status
echo Checking repository status...
git status
echo.

REM Add all files
echo Adding all files...
git add .
echo [OK] Files staged
echo.

REM Commit changes
echo Creating commit...
set /p commit_message="Enter commit message (or press Enter for default): "
if "%commit_message%"=="" set commit_message=✨ MarketTrack Mobile App - Beautiful UI with Appwrite Backend

git commit -m "%commit_message%"
echo [OK] Changes committed
echo.

REM Set main branch
echo Setting main branch...
git branch -M main
echo [OK] Branch set to main
echo.

REM Push to GitHub
echo ===============================================
echo   Pushing to GitHub...
echo ===============================================
echo.
echo IMPORTANT:
echo - Username: milandare26feb-ops
echo - Password: [YOUR_PERSONAL_ACCESS_TOKEN]
echo.
echo (Paste your token when asked for password)
echo.

git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ===============================================
    echo   SUCCESS! 🎉
    echo ===============================================
    echo.
    echo Your code is now on GitHub!
    echo Repository: https://github.com/milandare26feb-ops/marketing-management-system
    echo.
    echo GitHub Actions will automatically build APK
    echo Check: https://github.com/milandare26feb-ops/marketing-management-system/actions
    echo.
) else (
    echo.
    echo ===============================================
    echo   PUSH FAILED ❌
    echo ===============================================
    echo.
    echo Possible reasons:
    echo 1. Invalid Personal Access Token
    echo 2. Network connection issue
    echo 3. Repository access denied
    echo.
    echo Please check and try again.
    echo.
)

pause
