#!/bin/bash
# Fieldnotes Lite - 版本发布脚本
set -e

echo "=========================================="
echo "  Fieldnotes Lite 版本发布向导"
echo "=========================================="
echo ""

# 检查是否有未提交的更改
if [[ -n $(git status -s) ]]; then
    echo "⚠️  警告：有未提交的更改"
    git status -s
    echo ""
    read -p "是否继续? (y/n) " CONTINUE
    if [ "$CONTINUE" != "y" ]; then
        echo "已取消。"
        exit 1
    fi
fi

# 1. 运行测试
echo "1️⃣  运行测试..."
if poetry run python test_basic.py; then
    echo "✅ 测试通过"
else
    echo "❌ 测试失败！请修复后再发布。"
    exit 1
fi
echo ""

# 2. 显示当前版本
CURRENT_VERSION=$(poetry version -s)
echo "2️⃣  当前版本: $CURRENT_VERSION"
echo ""
echo "选择版本类型："
echo "  1) patch  - 修订版本 (bug修复)      例: $CURRENT_VERSION → $(poetry version patch --dry-run | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')"
echo "  2) minor  - 次版本 (新功能)         例: $CURRENT_VERSION → $(poetry version minor --dry-run | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')"
echo "  3) major  - 主版本 (重大更新)       例: $CURRENT_VERSION → $(poetry version major --dry-run | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')"
echo "  4) custom - 自定义版本号"
echo "  0) 取消"
echo ""
read -p "请选择 (0-4): " VERSION_TYPE

case $VERSION_TYPE in
    1)
        NEW_VERSION=$(poetry version patch | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
        ;;
    2)
        NEW_VERSION=$(poetry version minor | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
        ;;
    3)
        NEW_VERSION=$(poetry version major | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
        ;;
    4)
        read -p "输入新版本号 (例如 0.2.0): " CUSTOM_VERSION
        NEW_VERSION=$(poetry version $CUSTOM_VERSION | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
        ;;
    0)
        echo "已取消。"
        exit 0
        ;;
    *)
        echo "无效选择。"
        exit 1
        ;;
esac

echo ""
echo "✅ 版本已更新: $CURRENT_VERSION → $NEW_VERSION"
echo ""

# 3. 更新 CHANGELOG
echo "3️⃣  更新 CHANGELOG.md"
echo ""
echo "请在编辑器中更新 CHANGELOG.md，记录此版本的更新内容。"
echo "完成后保存并关闭编辑器。"
echo ""
read -p "按回车打开编辑器..." 
${EDITOR:-nano} CHANGELOG.md

echo ""
read -p "CHANGELOG 已更新? (y/n) " CHANGELOG_DONE
if [ "$CHANGELOG_DONE" != "y" ]; then
    echo "请手动更新 CHANGELOG.md 后重新运行此脚本。"
    exit 1
fi

# 4. 提交更改
echo ""
echo "4️⃣  提交更改..."
git add pyproject.toml CHANGELOG.md
git commit -m "Release v$NEW_VERSION"
echo "✅ 已提交"
echo ""

# 5. 创建标签
echo "5️⃣  创建 Git 标签 v$NEW_VERSION..."
git tag -a v$NEW_VERSION -m "Release v$NEW_VERSION"
echo "✅ 标签已创建"
echo ""

# 6. 构建分发包
echo "6️⃣  构建分发包..."
poetry build
echo "✅ 构建完成"
echo ""

# 7. 发布到 PyPI
echo "7️⃣  发布到 PyPI"
read -p "是否发布到 PyPI? (y/n) " PUBLISH_PYPI
if [ "$PUBLISH_PYPI" = "y" ]; then
    echo "选择发布目标："
    echo "  1) TestPyPI (测试)"
    echo "  2) PyPI (正式)"
    read -p "请选择 (1-2): " PYPI_TARGET
    
    if [ "$PYPI_TARGET" = "1" ]; then
        echo "发布到 TestPyPI..."
        poetry publish -r testpypi
    elif [ "$PYPI_TARGET" = "2" ]; then
        echo "发布到 PyPI..."
        poetry publish
    fi
    echo "✅ 已发布"
else
    echo "⏭️  跳过 PyPI 发布"
fi
echo ""

# 8. 推送到 GitHub
echo "8️⃣  推送到 GitHub..."
read -p "是否推送到 GitHub? (y/n) " PUSH_GITHUB
if [ "$PUSH_GITHUB" = "y" ]; then
    git push
    git push origin v$NEW_VERSION
    echo "✅ 已推送到 GitHub"
else
    echo "⏭️  跳过 GitHub 推送"
    echo "⚠️  记得手动推送: git push && git push origin v$NEW_VERSION"
fi
echo ""

# 完成
echo "=========================================="
echo "  🎉 发布完成！v$NEW_VERSION"
echo "=========================================="
echo ""
echo "📋 下一步："
echo ""
echo "1. 在 GitHub 上创建 Release："
echo "   https://github.com/yourusername/fieldnote/releases/new"
echo ""
echo "2. 构建可执行文件（可选）："
echo "   ./build_executable.sh"
echo ""
echo "3. 上传可执行文件到 GitHub Release"
echo ""
echo "4. 发布更新公告"
echo ""
echo "=========================================="

