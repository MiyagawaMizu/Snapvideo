@echo off
title YouTube / Instagram / TikTok Downloader
chcp 65001 >nul

:: Set working and output directories
cd /d C:\yt-dlp
set "OUTPUT_DIR=%USERPROFILE%\Downloads\Videos"
set "FFMPEG_PATH=C:\ffmpeg\bin"

:: Add FFmpeg to PATH temporarily
set "PATH=%FFMPEG_PATH%;%PATH%"

:: Display header
echo.
echo ================================
echo    YouTube / Instagram / TikTok Downloader
echo ================================
echo.

:loop
set /p "VIDEO_URL=Paste video URL (or type 'exit' to quit): "

if /i "%VIDEO_URL%"=="exit" goto end

echo.
echo Downloading...
yt-dlp --ffmpeg-location "%FFMPEG_PATH%" -P "%OUTPUT_DIR%" "%VIDEO_URL%"
echo.
goto loop

:end
echo.
echo Goodbye!
pause
