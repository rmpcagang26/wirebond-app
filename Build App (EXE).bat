@echo off
title Wire Bond Group — EXE Builder
color 0A

echo.
echo  =====================================================
echo    Wire Bond Group — Activity Flow System
echo    EXE Builder (powered by PyInstaller)
echo  =====================================================
echo.
echo  This will package the app into a standalone .exe
echo  that runs WITHOUT needing Python installed.
echo.
pause

:: ── Step 1: Install PyInstaller ───────────────────────────────────────────
echo.
echo [1/4] Installing / updating PyInstaller...
pip install --upgrade pyinstaller >nul 2>&1
if %errorlevel% neq 0 (
    echo  ERROR: pip install failed. Make sure Python is installed and in PATH.
    pause & exit /b 1
)
echo        Done.

:: ── Step 2: Clean previous build ─────────────────────────────────────────
echo.
echo [2/4] Cleaning previous build...
if exist dist\WireBondActivityFlow rmdir /s /q dist\WireBondActivityFlow
if exist build rmdir /s /q build
:: NOTE: Do NOT delete WireBondActivityFlow.spec — we need it for the build!
echo        Done.

:: ── Step 3: Run PyInstaller via spec file ────────────────────────────────
echo.
echo [3/4] Building EXE — this takes 1-3 minutes, please wait...
echo.

:: Using WireBondActivityFlow.spec for reliable bundling of pywebview.
:: The spec file uses collect_all('webview') in Python directly, which is
:: more reliable than --collect-all on the command line for packages that
:: use dynamic/conditional imports.
pyinstaller --noconfirm WireBondActivityFlow.spec

if %errorlevel% neq 0 (
    echo.
    echo  BUILD FAILED. Check the errors above.
    echo  Common fix: run "Install Dependencies.bat" first.
    pause & exit /b 1
)

:: ── Step 4: Done ─────────────────────────────────────────────────────────
echo.
echo [4/4] Build complete!
echo.
echo  ┌─────────────────────────────────────────────────────────┐
echo  │                                                         │
echo  │   Your app is ready at:                                 │
echo  │   dist\WireBondActivityFlow\WireBondActivityFlow.exe    │
echo  │                                                         │
echo  │   HOW TO SHARE / INSTALL ON ANOTHER PC:                │
echo  │   1. Copy the entire  dist\WireBondActivityFlow\        │
echo  │      folder to the target computer.                     │
echo  │   2. Double-click  WireBondActivityFlow.exe             │
echo  │   3. Python does NOT need to be installed on that PC.   │
echo  │   4. Windows 10/11 with Edge WebView2 is required       │
echo  │      (already installed on most Windows 10/11 PCs).    │
echo  │                                                         │
echo  │   NOTE: Keep all files in the folder together.          │
echo  │   The database and uploads are saved next to the .exe   │
echo  │                                                         │
echo  └─────────────────────────────────────────────────────────┘
echo.
pause
