@echo off
setlocal enabledelayedexpansion

echo ===================================================
echo Liblouis Web Deployment Script
echo ===================================================

:: Step 1: Initialize Git
set /p confirm_init="Initialize Git repository? (y/n): "
if /i "%confirm_init%"=="y" (
    git init
    echo Git initialized.
)

:: Step 2: Add Files
set /p confirm_add="Add all files to staging? (y/n): "
if /i "%confirm_add%"=="y" (
    git add .
    echo Files added.
)

:: Step 3: Commit
set /p confirm_commit="Commit changes? (y/n): "
if /i "%confirm_commit%"=="y" (
    set /p commit_msg="Enter commit message (default: Initial deploy): "
    if "!commit_msg!"=="" set commit_msg=Initial deploy
    git commit -m "!commit_msg!"
    echo Committed.
)

:: Step 4: Remote Configuration
:remote_config
set /p repo_url="Enter GitHub repository URL (e.g., https://github.com/salorajan/liblouis-web.git): "
if "!repo_url!"=="" (
    echo Error: URL cannot be empty.
    goto remote_config
)
git remote remove origin >nul 2>&1
git remote add origin !repo_url!
echo Remote origin set to !repo_url!

:: Step 5: Push
:: Detect current branch name
for /f "tokens=*" %%i in ('git rev-parse --abbrev-ref HEAD') do set current_branch=%%i
set /p confirm_push="Push to GitHub branch '!current_branch!'? (y/n): "
if /i "%confirm_push%"=="y" (
    git push -u origin !current_branch!
    if !errorlevel! neq 0 (
        echo.
        echo Error: Push failed. Check your internet or if the repository exists on GitHub.
    ) else (
        echo Pushed to GitHub.
    )
)

echo.
echo ===================================================
echo Deployment Steps Complete!
echo Make sure GitHub Actions starts the build.
echo GitHub Pages will be available at: https://salorajan.github.io/[repo-name]/
echo ===================================================
pause
