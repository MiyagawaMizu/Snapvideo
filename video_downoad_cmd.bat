@echo off
title Universal Video Downloader (yt-dlp)
chcp 65001 >nul

:: Thiết lập thư mục làm việc và thư mục đầu ra
cd /d C:\yt-dlp
set "OUTPUT_DIR=%USERPROFILE%\Downloads\Videos_downloader"
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

:: Lệnh tải xuống (Đã sửa lỗi tên file quá dài và ký tự đặc biệt)
yt-dlp ^
--ffmpeg-location "%FFMPEG_PATH%" ^
-P "%OUTPUT_DIR%" ^
-o "%%(title).50s [%%(id)s].%%(ext)s" ^
--restrict-filenames ^
--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" ^
-f "bestvideo+bestaudio/best" ^
--geo-bypass ^
"%VIDEO_URL%"

:: Kiểm tra kết quả, chỉ mở thư mục nếu tải thành công
if %ERRORLEVEL% equ 0 (
    echo.
    echo [SUCCESS] Download completed.
    echo Opening download folder...
    start "" "%OUTPUT_DIR%"
) else (
    echo.
    echo [ERROR] Download failed. Please check the URL.
)

goto loop

:end
echo.
echo Goodbye!
pause