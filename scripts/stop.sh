#!/bin/bash
# Fieldnote Lite - 安全停止脚本

echo "正在停止 Fieldnote Lite..."

# 查找 Fieldnote Lite 进程（更精确的匹配）
# 匹配包含当前目录路径的 main.py
CURRENT_DIR=$(pwd)
PID=$(ps aux | grep "python.*${CURRENT_DIR}/main.py" | grep -v grep | awk '{print $2}')

if [ -z "$PID" ]; then
    echo "未找到运行中的 Fieldnote Lite 进程"
    
    # 检查锁文件
    if [ "$(uname)" = "Darwin" ]; then
        LOCK_FILE="/tmp/fieldnote_lite.lock"
    else
        LOCK_FILE="/tmp/fieldnote_lite.lock"
    fi
    
    if [ -f "$LOCK_FILE" ]; then
        echo "发现残留的锁文件，正在清理..."
        rm -f "$LOCK_FILE"
        echo "✅ 锁文件已清理"
    fi
else
    echo "找到进程 PID: $PID"
    kill $PID
    sleep 1
    
    # 检查是否成功停止
    if ps -p $PID > /dev/null 2>&1; then
        echo "进程未响应，强制停止..."
        kill -9 $PID
    fi
    
    echo "✅ Fieldnote Lite 已停止"
fi

