@echo off
REM Fieldnote Lite 启动脚本 (Windows)

echo ==========================================
echo   Fieldnote Lite
echo   田野笔记管理工具
echo ==========================================
echo.

REM 检查Python
where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo 错误: 未找到Python，请先安装Python 3.11或更高版本
    pause
    exit /b 1
)

REM 检查Poetry是否安装
where poetry >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo 使用 Poetry 管理依赖...
    
    REM 检查是否已安装依赖
    if not exist ".venv" if not exist "poetry.lock" (
        echo 首次运行，正在安装依赖...
        poetry install
    )
    
    echo.
    echo 启动程序...
    poetry run python main.py
) else (
    echo Poetry 未安装，使用传统方式...
    echo （推荐安装 Poetry: 访问 https://python-poetry.org/docs/#installation）
    echo.
    
    REM 检查虚拟环境
    if not exist "venv" (
        echo 创建虚拟环境...
        python -m venv venv
    )
    
    echo 激活虚拟环境并检查依赖...
    call venv\Scripts\activate.bat
    
    REM 检查PyQt6
    python -c "import PyQt6" >nul 2>nul
    if %ERRORLEVEL% NEQ 0 (
        echo 正在安装依赖包...
        pip install -r requirements.txt
    )
    
    echo.
    echo 启动程序...
    python main.py
)

pause
