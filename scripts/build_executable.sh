#!/bin/bash
# Fieldnote Lite - 可执行文件构建脚本 (macOS/Linux)

echo "=========================================="
echo "  Fieldnote Lite - 构建可执行文件"
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
# 使用自定义 Fieldnote.spec（已配置排除 Qt 权限插件）
poetry run pyinstaller \
    --clean \
    --noconfirm \
    Fieldnote.spec

echo ""
echo "测试启动..."
sleep 2
# 在后台测试启动
./dist/Fieldnote.app/Contents/MacOS/Fieldnote &
TESTPID=$!
sleep 3
if ps -p $TESTPID > /dev/null 2>&1; then
    echo "✅ 程序可以正常启动"
    kill $TESTPID 2>/dev/null
else
    echo "⚠️  程序可能有启动问题，但已构建完成"
fi

# 检查结果
if [ -d "dist/Fieldnote" ]; then
    echo ""
    echo "=========================================="
    echo "  构建成功！"
    echo "=========================================="
    echo ""
    echo "可执行文件位于: dist/Fieldnote/"
    echo ""
    
    # 显示文件大小
    du -sh dist/Fieldnote/
    
    echo ""
    echo "运行程序："
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "  open dist/Fieldnote/Fieldnote.app"
    else
        echo "  ./dist/Fieldnote/Fieldnote"
    fi
    echo ""
    echo "创建分发包："
    echo "  cd dist && tar -czf Fieldnote-$(uname -s)-$(uname -m).tar.gz Fieldnote/"
else
    echo ""
    echo "构建失败！请检查错误信息。"
    exit 1
fi

