@echo off
title Universal Video Downloader (yt-dlp)
chcp 65001 >nul

:: Thiết lập thư mục làm việc và thư mục đầu ra
cd /d C:\yt-dlp
set "OUTPUT_DIR=%USERPROFILE%\Downloads\Videos"
set "FFMPEG_PATH=C:\ffmpeg\bin"

:: Thêm FFmpeg vào PATH tạm thời
set "PATH=%FFMPEG_PATH%;%PATH%"

:: Hiển thị tiêu đề
echo.
echo ==============================================
echo    Universal Video Downloader (yt-dlp)
echo ==============================================
echo.

:: BƯỚC QUAN TRỌNG: CẬP NHẬT YT-DLP ĐỂ KHẮC PHỤC LỖI YOUTUBE 403
echo [INFO] Checking for yt-dlp update...
yt-dlp -U
ping 127.0.0.1 -n 2 > nul
echo.

:loop
set /p "VIDEO_URL=Paste video URL (or type 'exit' to quit): "

if /i "%VIDEO_URL%"=="exit" goto end

echo.
echo Downloading...

:: Lệnh tải xuống tiêu chuẩn
yt-dlp ^
--ffmpeg-location "%FFMPEG_PATH%" ^
-P "%OUTPUT_DIR%" ^
--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" ^
-f "bestvideo+bestaudio/best" ^
--geo-bypass ^
"%VIDEO_URL%"

echo.

:: Sau khi tải xong, tự mở thư mục chứa video
echo Opening download folder...
start "" "%OUTPUT_DIR%"

goto loop

:end
echo.
echo Goodbye!
pause