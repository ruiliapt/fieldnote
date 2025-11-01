#!/bin/bash
# Fieldnotes Lite - 可执行文件构建脚本 (macOS/Linux)

echo "=========================================="
echo "  Fieldnotes Lite - 构建可执行文件"
echo "=========================================="
echo ""

# 检查 PyInstaller
if ! poetry run python -c "import PyInstaller" 2>/dev/null; then
    echo "安装 PyInstaller..."
    poetry add --group dev pyinstaller
fi

# 清理旧的构建（保留 spec 文件）
echo "清理旧的构建文件..."
rm -rf build dist

# 打包
echo ""
echo "开始打包（macOS .app 模式，使用自定义 spec 排除问题插件）..."
# 使用自定义 Fieldnotes.spec（已配置排除 Qt 权限插件）
poetry run pyinstaller \
    --clean \
    --noconfirm \
    Fieldnotes.spec

echo ""
echo "测试启动..."
sleep 2
# 在后台测试启动
./dist/Fieldnotes.app/Contents/MacOS/Fieldnotes &
TESTPID=$!
sleep 3
if ps -p $TESTPID > /dev/null 2>&1; then
    echo "✅ 程序可以正常启动"
    kill $TESTPID 2>/dev/null
else
    echo "⚠️  程序可能有启动问题，但已构建完成"
fi

# 检查结果
if [ -d "dist/Fieldnotes" ]; then
    echo ""
    echo "=========================================="
    echo "  构建成功！"
    echo "=========================================="
    echo ""
    echo "可执行文件位于: dist/Fieldnotes/"
    echo ""
    
    # 显示文件大小
    du -sh dist/Fieldnotes/
    
    echo ""
    echo "运行程序："
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "  open dist/Fieldnotes/Fieldnotes.app"
    else
        echo "  ./dist/Fieldnotes/Fieldnotes"
    fi
    echo ""
    echo "创建分发包："
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "  cd dist && tar -czf Fieldnotes-macOS.tar.gz Fieldnotes.app"
    else
        echo "  cd dist && tar -czf Fieldnotes-$(uname -s)-$(uname -m).tar.gz Fieldnotes/"
    fi
else
    echo ""
    echo "构建失败！请检查错误信息。"
    exit 1
fi

