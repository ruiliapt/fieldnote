#!/bin/bash
# Fieldnote Lite 启动脚本
# 双击此文件即可启动程序

cd "$(dirname "$0")"

echo "=========================================="
echo "  Fieldnote Lite"
echo "  田野笔记管理工具"
echo "=========================================="
echo ""
echo "正在启动程序..."
echo ""

# 使用 Poetry 运行
if command -v poetry &> /dev/null; then
    poetry run python main.py
else
    # 使用虚拟环境
    if [ -d "venv" ]; then
        source venv/bin/activate
        python main.py
    else
        echo "错误：请先运行 ./run.sh 安装依赖"
        read -p "按回车键退出..."
    fi
fi

