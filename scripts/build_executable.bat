@echo off
REM Fieldnotes Lite - 可执行文件构建脚本 (Windows)

echo ==========================================
echo   Fieldnotes Lite - 构建可执行文件
echo ==========================================
echo.

REM 检查 PyInstaller
poetry run python -c "import PyInstaller" 2>nul
if errorlevel 1 (
    echo 安装 PyInstaller...
    poetry add --group dev pyinstaller
)

REM 清理旧的构建
echo 清理旧的构建文件...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist *.spec del /q *.spec

REM 打包
echo.
echo 开始打包...
poetry run pyinstaller ^
    --name=Fieldnotes ^
    --windowed ^
    --add-data="README.md;." ^
    --hidden-import=PyQt6 ^
    --hidden-import=PyQt6.QtCore ^
    --hidden-import=PyQt6.QtGui ^
    --hidden-import=PyQt6.QtWidgets ^
    --hidden-import=docx ^
    --hidden-import=pandas ^
    --hidden-import=sqlite3 ^
    --clean ^
    --noconfirm ^
    main.py

REM 检查结果
if exist "dist\Fieldnotes" (
    echo.
    echo ==========================================
    echo   构建成功！
    echo ==========================================
    echo.
    echo 可执行文件位于: dist\Fieldnotes\
    echo.
    echo 运行程序：
    echo   dist\Fieldnotes\Fieldnotes.exe
    echo.
) else (
    echo.
    echo 构建失败！请检查错误信息。
    exit /b 1
)

pause

