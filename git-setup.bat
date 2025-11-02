@echo off
REM ================================================
REM  GitHub Authentication Setup Script
REM  MarketTrack Mobile App
REM ================================================

echo.
echo ===============================================
echo   GitHub Authentication Setup
echo   MarketTrack Mobile App
echo ===============================================
echo.

REM Check if Git is installed
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Git is not installed!
    echo.
    echo Please install Git first:
    echo https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

echo [OK] Git is installed
echo.

REM Configure Git user
echo Configuring Git user...
git config --global user.name "Milan Dare"
git config --global user.email "ibnatfm@gmail.com"
echo [OK] Git user configured
echo.

REM Initialize Git repository
echo Initializing Git repository...
cd /d D:\MARKET_MANAGEMENT
if not exist .git (
    git init
    echo [OK] Git repository initialized
) else (
    echo [OK] Git repository already exists
)
echo.

REM Add remote origin
echo Adding GitHub remote...
git remote remove origin 2>nul
git remote add origin https://github.com/milandare26feb-ops/marketing-management-system.git
echo [OK] Remote added
echo.

REM Show current status
echo Current Git Status:
git status --short
echo.

echo ===============================================
echo   Setup Complete!
echo ===============================================
echo.
echo Next Steps:
echo.
echo 1. Copy your GitHub Personal Access Token
echo 2. Run: git-push.bat
echo.
pause
