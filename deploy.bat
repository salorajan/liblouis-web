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
set /p confirm_remote="Configure remote repository? (y/n): "
if /i "%confirm_remote%"=="y" (
    set /p repo_url="Enter GitHub repository URL (e.g., https://github.com/salorajan/liblouis-web.git): "
    git remote remove origin >nul 2>&1
    git remote add origin !repo_url!
    echo Remote origin set to !repo_url!
)

:: Step 5: Push
set /p confirm_push="Push to GitHub? (y/n): "
if /i "%confirm_push%"=="y" (
    set /p branch_name="Enter branch name (default: main): "
    if "!branch_name!"=="" set branch_name=main
    git push -u origin !branch_name!
    echo Pushed to GitHub.
)

echo.
echo ===================================================
echo Deployment Steps Complete!
echo Make sure GitHub Actions starts the build.
echo GitHub Pages will be available at: https://salorajan.github.io/[repo-name]/
echo ===================================================
pause
