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

:loop
set /p "VIDEO_URL=Paste video URL (or type 'exit' to quit): "

if /i "%VIDEO_URL%"=="exit" goto end

echo.
echo Downloading...

:: Thực thi lệnh tải xuống (Đã sửa lỗi tên file quá dài)
yt-dlp ^
--ffmpeg-location "%FFMPEG_PATH%" ^
-P "%OUTPUT_DIR%" ^
-o "%%(title).50s [%%(id)s].%%(ext)s" ^
--restrict-filenames ^
--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" ^
-f "bestvideo+bestaudio/best" ^
--geo-bypass ^
"%VIDEO_URL%"

:: Kiểm tra kết quả của lệnh yt-dlp vừa chạy
if %ERRORLEVEL% equ 0 (
    echo.
    echo [SUCCESS] Download completed.
    echo Opening download folder...
    
    :: Chỉ mở folder khi tải thành công
    start "" "%OUTPUT_DIR%"
) else (
    echo.
    echo [ERROR] Download failed or was cancelled. Folder not opened.
    
    :: KỸ THUẬT MỚI: Chỉ cập nhật yt-dlp nếu tải xuống thất bại VÀ đó là URL YouTube.
    if /i not "%VIDEO_URL:youtube.com=%"=="%VIDEO_URL%" (
        echo [INFO] Detected YouTube URL failure. This is often a HTTP Error 403.
        echo [ACTION] Running yt-dlp -U to update and fix potential issues...
        
        :: Cập nhật yt-dlp
        yt-dlp -U
        
        ping 127.0.0.1 -n 2 > nul
        echo.
        echo [HINT] Please paste the video URL again to retry the download.
    ) else (
        echo [HINT] Please check the URL and your connection, then try again.
    )
)

goto loop

:end
echo.
echo Goodbye!
pause