#!/bin/bash
# Fieldnote Lite 启动脚本

echo "=========================================="
echo "  Fieldnote Lite"
echo "  田野笔记管理工具"
echo "=========================================="
echo ""

# 检查Python版本
if ! command -v python3 &> /dev/null; then
    echo "错误: 未找到Python3，请先安装Python 3.11或更高版本"
    exit 1
fi

# 检查Poetry是否安装
if command -v poetry &> /dev/null; then
    echo "使用 Poetry 管理依赖..."
    
    # 检查是否已安装依赖
    if [ ! -d ".venv" ] && [ ! -f "poetry.lock" ]; then
        echo "首次运行，正在安装依赖..."
        poetry install
    fi
    
    echo ""
    echo "启动程序..."
    poetry run python main.py
else
    echo "Poetry 未安装，使用传统方式..."
    echo "（推荐安装 Poetry: curl -sSL https://install.python-poetry.org | python3 -）"
    echo ""
    
    # 检查虚拟环境
    if [ ! -d "venv" ]; then
        echo "创建虚拟环境..."
        python3 -m venv venv
    fi
    
    echo "激活虚拟环境并检查依赖..."
    source venv/bin/activate
    
    # 检查是否安装了必要的包
    python3 -c "import PyQt6" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "正在安装依赖包..."
        pip install -r requirements.txt
    fi
    
    echo ""
    echo "启动程序..."
    python main.py
fi
