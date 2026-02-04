@echo off
setlocal ENABLEDELAYEDEXPANSION

title Universal Video Downloader (yt-dlp)
chcp 65001 >nul

:: ===== Cấu hình =====
cd /d "C:\yt-dlp" 2>nul || (
    echo [ERROR] Khong tim thay thu muc C:\yt-dlp
    echo Hay kiem tra lai duong dan yt-dlp.exe.
    pause
    exit /b 1
)

set "OUTPUT_DIR=%USERPROFILE%\Downloads\Videos_downloader"
set "FFMPEG_PATH=C:\ffmpeg\bin"

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%" 2>nul

:: Thêm FFmpeg vào PATH tạm thời (nếu có)
if exist "%FFMPEG_PATH%\ffmpeg.exe" (
    set "PATH=%FFMPEG_PATH%;%PATH%"
) else (
    echo [WARN] Khong tim thay ffmpeg.exe trong "%FFMPEG_PATH%". Van tiep tuc khong co FFmpeg.
)

echo.
echo ==============================================
echo Universal Video Downloader (yt-dlp)
echo ==============================================
echo.

:loop
set "VIDEO_URL="
set /p "VIDEO_URL=Paste video URL (or type 'exit' to quit): "

if /i "%VIDEO_URL%"=="exit" goto end
if "%VIDEO_URL%"=="" (
    echo [WARN] URL rong, vui long nhap lai.
    echo.
    goto loop
)

echo.
echo Downloading...

:: Xay command ra bien de de debug khi loi
set "CMD=yt-dlp --ffmpeg-location \"%FFMPEG_PATH%\" -P \"%OUTPUT_DIR%\" -o \"%%(title).50s [%%(id)s].%%(ext)s\" --restrict-filenames --user-agent \"Mozilla/5.0 (Windows NT 10.0; Win64; x64)\" -f \"bestvideo+bestaudio/best\" --geo-bypass \"%VIDEO_URL%\""

:: (optional) echo !CMD!
:: call de thuc thi chuoi lenh
call !CMD!
set "EXITCODE=%ERRORLEVEL%"

if "!EXITCODE!"=="0" (
    echo.
    echo [SUCCESS] Download completed.
    echo Opening download folder...
    start "" "%OUTPUT_DIR%"
) else (
    echo.
    echo [ERROR] Download failed or was cancelled. (Exit code: !EXITCODE!)

    :: Neu la URL YouTube thi goi update 1 lan
    echo %VIDEO_URL% | findstr /I "youtube.com youtu.be" >nul
    if not errorlevel 1 (
        echo [INFO] Detected YouTube URL failure.
        echo [ACTION] Running yt-dlp -U ...
        yt-dlp -U
        echo.
        echo [HINT] Please paste the video URL again to retry the download.
    ) else (
        echo [HINT] Please check the URL and your connection, then try again.
    )
)

echo.
goto loop

:end
echo.
echo Goodbye!
pause
endlocal
@echo off
setlocal ENABLEDELAYEDEXPANSION

title Universal Video Downloader (yt-dlp)
chcp 65001 >nul

:: ===== Cấu hình =====
cd /d "C:\yt-dlp" 2>nul || (
    echo [ERROR] Khong tim thay thu muc C:\yt-dlp
    echo Hay kiem tra lai duong dan yt-dlp.exe.
    pause
    exit /b 1
)

set "OUTPUT_DIR=%USERPROFILE%\Downloads\Videos_downloader"
set "FFMPEG_PATH=C:\ffmpeg\bin"

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%" 2>nul

:: Thêm FFmpeg vào PATH tạm thời (nếu có)
if exist "%FFMPEG_PATH%\ffmpeg.exe" (
    set "PATH=%FFMPEG_PATH%;%PATH%"
) else (
    echo [WARN] Khong tim thay ffmpeg.exe trong "%FFMPEG_PATH%". Van tiep tuc khong co FFmpeg.
)

echo.
echo ==============================================
echo Universal Video Downloader (yt-dlp)
echo ==============================================
echo.

:loop
set "VIDEO_URL="
set /p "VIDEO_URL=Paste video URL (or type 'exit' to quit): "

if /i "%VIDEO_URL%"=="exit" goto end
if "%VIDEO_URL%"=="" (
    echo [WARN] URL rong, vui long nhap lai.
    echo.
    goto loop
)

echo.
echo Downloading...

:: Xay command ra bien de de debug khi loi
set "CMD=yt-dlp --ffmpeg-location \"%FFMPEG_PATH%\" -P \"%OUTPUT_DIR%\" -o \"%%(title).50s [%%(id)s].%%(ext)s\" --restrict-filenames --user-agent \"Mozilla/5.0 (Windows NT 10.0; Win64; x64)\" -f \"bestvideo+bestaudio/best\" --geo-bypass \"%VIDEO_URL%\""

:: (optional) echo !CMD!
:: call de thuc thi chuoi lenh
call !CMD!
set "EXITCODE=%ERRORLEVEL%"

if "!EXITCODE!"=="0" (
    echo.
    echo [SUCCESS] Download completed.
    echo Opening download folder...
    start "" "%OUTPUT_DIR%"
) else (
    echo.
    echo [ERROR] Download failed or was cancelled. (Exit code: !EXITCODE!)

    :: Neu la URL YouTube thi goi update 1 lan
    echo %VIDEO_URL% | findstr /I "youtube.com youtu.be" >nul
    if not errorlevel 1 (
        echo [INFO] Detected YouTube URL failure.
        echo [ACTION] Running yt-dlp -U ...
        yt-dlp -U
        echo.
        echo [HINT] Please paste the video URL again to retry the download.
    ) else (
        echo [HINT] Please check the URL and your connection, then try again.
    )
)

echo.
goto loop

:end
echo.
echo Goodbye!
pause
endlocal
