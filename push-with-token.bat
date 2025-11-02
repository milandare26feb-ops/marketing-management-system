@echo off
echo ================================================
echo   GitHub Push with Token
echo ================================================
echo.
echo Please paste your GitHub Personal Access Token:
set /p TOKEN=Token: 
echo.
echo Pushing to GitHub...
cd /d D:\MARKET_MANAGEMENT
"C:\Program Files\Git\bin\git.exe" push https://%TOKEN%@github.com/milandare26feb-ops/marketing-management-system.git main
echo.
if %ERRORLEVEL% EQU 0 (
    echo ================================================
    echo   SUCCESS! Push Complete!
    echo ================================================
    echo.
    echo Check your repository:
    echo https://github.com/milandare26feb-ops/marketing-management-system
) else (
    echo ================================================
    echo   FAILED! Check token and try again
    echo ================================================
)
echo.
pause
