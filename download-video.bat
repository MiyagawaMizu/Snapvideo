@echo off
title YouTube Video Downloader with yt-dlp
color 0A

:: Set download folder
set "OUTPUT_DIR=%USERPROFILE%\Downloads\Videos"

:: Add ffmpeg to PATH if needed (if not already set)
set "FFMPEG_DIR=C:\ffmpeg\bin"
set "PATH=%FFMPEG_DIR%;%PATH%"

:: Check yt-dlp existence
if not exist yt-dlp.exe (
    echo yt-dlp.exe not found in current folder.
    pause
    exit /b
)

:loop
cls
echo ==========================================
echo   YouTube / Instagram / TikTok Downloader
echo ==========================================
echo.

set /p "URL=Paste video URL (or type 'exit' to quit): "

if /i "%URL%"=="exit" goto end

echo Downloading...
yt-dlp.exe "%URL%" ^
  --ffmpeg-location "%FFMPEG_DIR%" ^
  -o "%OUTPUT_DIR%\%%(title)s.%%(ext)s" ^
  --merge-output-format mp4

echo.
echo Download finished!
echo Press any key to continue...
pause >nul
goto loop

:end
echo Exiting...
exit /b
