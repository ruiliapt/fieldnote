@echo off
REM Fieldnote Lite - 安全停止脚本 (Windows)

echo 正在停止 Fieldnote Lite...

REM 查找 Fieldnote Lite 进程
for /f "tokens=2" %%i in ('tasklist /FI "IMAGENAME eq python.exe" /FO LIST ^| findstr "PID"') do (
    set PID=%%i
)

if "%PID%"=="" (
    echo 未找到运行中的 Fieldnote Lite 进程
    
    REM 检查并清理锁文件
    set LOCK_FILE=%TEMP%\fieldnote_lite.lock
    if exist "%LOCK_FILE%" (
        echo 发现残留的锁文件，正在清理...
        del "%LOCK_FILE%"
        echo 锁文件已清理
    )
) else (
    echo 找到进程 PID: %PID%
    taskkill /PID %PID% /F
    echo Fieldnote Lite 已停止
)

pause

