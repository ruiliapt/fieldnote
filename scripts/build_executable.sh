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

# 在本地环境测试启动，CI 环境跳过（无 GUI）
if [ -z "$CI" ]; then
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
else
    echo "⏭️  CI 环境检测到，跳过 GUI 启动测试"
fi

# 检查结果
if [[ "$OSTYPE" == "darwin"* ]]; then
    BUILD_PATH="dist/Fieldnotes.app"
else
    BUILD_PATH="dist/Fieldnotes"
fi

if [ -e "$BUILD_PATH" ]; then
    echo ""
    echo "=========================================="
    echo "  构建成功！"
    echo "=========================================="
    echo ""
    echo "可执行文件位于: $BUILD_PATH"
    echo ""
    
    # 显示文件大小
    du -sh "$BUILD_PATH"
    
    echo ""
    echo "运行程序："
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "  open dist/Fieldnotes.app"
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
    echo "期望的构建路径: $BUILD_PATH"
    exit 1
fi

