# Fieldnote Lite - 发布指南

本文档说明如何发布 Fieldnote Lite 软件的各种方式。

---

## 📦 发布方式概览

| 方式 | 适用场景 | 优点 | 缺点 |
|------|---------|------|------|
| **PyPI发布** | Python用户 | 易于安装(`pip install`) | 需要Python环境 |
| **打包可执行文件** | 普通用户 | 无需Python环境 | 文件较大(~100MB) |
| **GitHub Releases** | 开发者/源码用户 | 包含源码，版本管理 | 需要Python环境 |
| **应用商店** | macOS/Windows用户 | 专业分发渠道 | 审核流程复杂 |

---

## 1️⃣ 发布到 PyPI (推荐给Python用户)

### 准备工作

1. **注册 PyPI 账号**
   - 访问：https://pypi.org/account/register/
   - 启用两步验证（可选但推荐）

2. **更新项目信息**
   
   编辑 `pyproject.toml`，更新作者信息：
   ```toml
   [tool.poetry]
   name = "fieldnote"
   version = "0.1.0"  # 版本号
   authors = ["Your Name <your.email@example.com>"]  # 改成你的信息
   ```

3. **检查项目完整性**
   ```bash
   # 确保所有测试通过
   poetry run python test_basic.py
   
   # 代码格式化
   make format
   
   # 代码检查
   make lint
   ```

### 构建和发布

```bash
# 1. 构建分发包
poetry build

# 这会在 dist/ 目录生成：
#   - fieldnote-0.1.0.tar.gz (源码包)
#   - fieldnote-0.1.0-py3-none-any.whl (wheel包)

# 2. 发布到 PyPI
poetry publish

# 会提示输入 PyPI 用户名和密码
# 或使用 API token:
poetry config pypi-token.pypi YOUR_TOKEN_HERE
poetry publish
```

### 用户安装方式

发布后，用户可以这样安装：
```bash
pip install fieldnote

# 运行程序
fieldnote
# 或
python -m fieldnote
```

---

## 2️⃣ 打包成可执行文件 (推荐给普通用户)

使用 PyInstaller 将程序打包成独立的可执行文件，无需Python环境。

### 安装 PyInstaller

```bash
poetry add --group dev pyinstaller
```

### 创建打包脚本

创建 `build_executable.sh` (macOS/Linux):
```bash
#!/bin/bash
# 清理旧的构建
rm -rf build dist

# 打包
poetry run pyinstaller \
    --name="Fieldnote" \
    --windowed \
    --icon=icon.icns \
    --add-data="README.md:." \
    --hidden-import=PyQt6 \
    --hidden-import=docx \
    --hidden-import=pandas \
    --clean \
    main.py

echo "构建完成！可执行文件位于: dist/Fieldnote/"
```

创建 `build_executable.bat` (Windows):
```batch
@echo off
REM 清理旧的构建
rmdir /s /q build dist

REM 打包
poetry run pyinstaller ^
    --name=Fieldnote ^
    --windowed ^
    --icon=icon.ico ^
    --add-data="README.md;." ^
    --hidden-import=PyQt6 ^
    --hidden-import=docx ^
    --hidden-import=pandas ^
    --clean ^
    main.py

echo 构建完成！可执行文件位于: dist\Fieldnote\
pause
```

### 打包步骤

```bash
# macOS/Linux
chmod +x build_executable.sh
./build_executable.sh

# Windows
build_executable.bat
```

生成的文件在 `dist/Fieldnote/` 目录：
- **macOS**: `Fieldnote.app`
- **Windows**: `Fieldnote.exe`
- **Linux**: `Fieldnote`

### 创建安装包

**macOS** - 使用 dmg-builder:
```bash
# 安装 create-dmg
brew install create-dmg

# 创建 DMG
create-dmg \
    --volname "Fieldnote Lite" \
    --window-pos 200 120 \
    --window-size 800 400 \
    --icon-size 100 \
    --app-drop-link 600 185 \
    "Fieldnote-0.1.0.dmg" \
    "dist/Fieldnote.app"
```

**Windows** - 使用 Inno Setup:
1. 下载安装 [Inno Setup](https://jrsoftware.org/isdl.php)
2. 创建安装脚本 `installer.iss`
3. 编译生成 `Fieldnote-Setup.exe`

---

## 3️⃣ 发布到 GitHub Releases

### 准备发布

1. **更新版本号和 CHANGELOG**
   
   创建 `CHANGELOG.md`:
   ```markdown
   # Changelog
   
   ## [0.1.0] - 2025-10-19
   
   ### Added
   - 初始版本发布
   - 数据录入和管理功能
   - 全文检索功能
   - Word文档导出功能
   - 批量导入JSON/CSV
   - 句号自动合并功能
   ```

2. **提交所有更改**
   ```bash
   git add .
   git commit -m "Release v0.1.0"
   git push
   ```

3. **创建标签**
   ```bash
   git tag -a v0.1.0 -m "Release version 0.1.0"
   git push origin v0.1.0
   ```

### 在 GitHub 上创建 Release

1. 访问你的 GitHub 仓库
2. 点击 "Releases" → "Create a new release"
3. 选择标签: `v0.1.0`
4. 标题: `Fieldnote Lite v0.1.0`
5. 描述（使用 CHANGELOG 内容）
6. 上传文件：
   - 源码压缩包（GitHub 自动生成）
   - macOS: `Fieldnote-0.1.0.dmg`
   - Windows: `Fieldnote-Setup-0.1.0.exe`
   - Linux: `Fieldnote-0.1.0-linux.tar.gz`
7. 点击 "Publish release"

### Release 描述模板

```markdown
# Fieldnote Lite v0.1.0

田野笔记管理工具 - 专为语言学田野调查设计

## ✨ 主要功能

- ✅ 数据录入：支持原文、词汇分解、翻译、备注
- ✅ 数据管理：增删改查，支持Unicode和IPA字符
- ✅ 检索功能：全文搜索和字段搜索
- ✅ Word导出：标准三行对照表格格式
- ✅ 批量导入：支持JSON和CSV格式
- ✅ 智能处理：自动合并句末标点

## 📥 下载安装

### 方式一：Python用户
```bash
pip install fieldnote
fieldnote
```

### 方式二：独立可执行文件

- **macOS**: 下载 `Fieldnote-0.1.0.dmg`
- **Windows**: 下载 `Fieldnote-Setup-0.1.0.exe`
- **Linux**: 下载 `Fieldnote-0.1.0-linux.tar.gz`

### 方式三：源码安装
```bash
git clone https://github.com/yourusername/fieldnote.git
cd fieldnote
poetry install
poetry run python main.py
```

## 📚 文档

- [README](README.md) - 项目说明
- [QUICKSTART](QUICKSTART.md) - 快速开始
- [INSTALL](INSTALL.md) - 详细安装说明

## 🐛 问题反馈

如有问题或建议，请在 [Issues](https://github.com/yourusername/fieldnote/issues) 中提交。

---

**完整更新日志**: [CHANGELOG.md](CHANGELOG.md)
```

---

## 4️⃣ 更新 Makefile

在 `Makefile` 中添加发布相关命令：

```makefile
# 添加到现有 Makefile

publish-test:  ## 发布到 TestPyPI（测试）
	poetry publish -r testpypi

publish:  ## 发布到 PyPI（正式）
	poetry build
	poetry publish

release:  ## 创建新版本发布
	@echo "当前版本: $(shell poetry version -s)"
	@read -p "输入新版本号 (例如 0.1.1): " VERSION; \
	poetry version $$VERSION && \
	git add pyproject.toml && \
	git commit -m "Bump version to $$VERSION" && \
	git tag -a v$$VERSION -m "Release v$$VERSION" && \
	git push && \
	git push origin v$$VERSION

build-exe:  ## 构建可执行文件
	./build_executable.sh

version:  ## 显示当前版本
	@poetry version
```

---

## 5️⃣ 版本管理策略

采用 [语义化版本](https://semver.org/lang/zh-CN/)：

- **主版本号 (MAJOR)**: 不兼容的API修改
- **次版本号 (MINOR)**: 向下兼容的功能性新增
- **修订号 (PATCH)**: 向下兼容的问题修正

示例：
```bash
# 修订版本（bug修复）
poetry version patch   # 0.1.0 → 0.1.1

# 次版本（新功能）
poetry version minor   # 0.1.1 → 0.2.0

# 主版本（重大更新）
poetry version major   # 0.2.0 → 1.0.0
```

---

## 6️⃣ 完整发布流程

### 发布检查清单

- [ ] 所有测试通过
- [ ] 代码已格式化并通过 lint
- [ ] 更新版本号
- [ ] 更新 CHANGELOG.md
- [ ] 更新文档
- [ ] 提交所有更改
- [ ] 创建 Git 标签
- [ ] 构建分发包
- [ ] 发布到 PyPI
- [ ] 创建 GitHub Release
- [ ] 上传可执行文件
- [ ] 发布公告（如果有社交媒体）

### 快速发布脚本

创建 `release.sh`:
```bash
#!/bin/bash
set -e

echo "=========================================="
echo "  Fieldnote Lite 发布脚本"
echo "=========================================="
echo ""

# 1. 检查测试
echo "1. 运行测试..."
make test

# 2. 更新版本
echo ""
echo "2. 当前版本: $(poetry version -s)"
read -p "输入新版本号 (例如 0.1.1): " VERSION
poetry version $VERSION

# 3. 更新 CHANGELOG
echo ""
echo "3. 请更新 CHANGELOG.md，完成后按回车继续..."
read

# 4. 提交更改
echo ""
echo "4. 提交更改..."
git add .
git commit -m "Release v$VERSION"

# 5. 创建标签
echo ""
echo "5. 创建标签 v$VERSION..."
git tag -a v$VERSION -m "Release v$VERSION"

# 6. 构建
echo ""
echo "6. 构建分发包..."
poetry build

# 7. 发布到 PyPI
echo ""
read -p "是否发布到 PyPI? (y/n) " PUBLISH
if [ "$PUBLISH" = "y" ]; then
    poetry publish
fi

# 8. 推送到 GitHub
echo ""
echo "8. 推送到 GitHub..."
git push
git push origin v$VERSION

echo ""
echo "=========================================="
echo "  发布完成！v$VERSION"
echo "=========================================="
echo ""
echo "下一步："
echo "1. 访问 GitHub 创建 Release"
echo "2. 上传可执行文件到 Release"
echo "3. 发布更新公告"
```

---

## 7️⃣ 持续集成 (可选)

创建 `.github/workflows/release.yml` 实现自动发布：

```yaml
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  build-and-release:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest, windows-latest]
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Install Poetry
      run: |
        curl -sSL https://install.python-poetry.org | python3 -
    
    - name: Install dependencies
      run: poetry install
    
    - name: Run tests
      run: poetry run python test_basic.py
    
    - name: Build executable
      run: |
        poetry add --group dev pyinstaller
        poetry run pyinstaller --name=Fieldnote --windowed main.py
    
    - name: Upload Release Asset
      uses: actions/upload-artifact@v3
      with:
        name: fieldnote-${{ matrix.os }}
        path: dist/
```

---

## 📞 技术支持

发布后如何提供支持：

1. **GitHub Issues**: 问题报告和功能请求
2. **GitHub Discussions**: 用户讨论和Q&A
3. **文档网站**: 使用 GitHub Pages 托管文档
4. **邮件列表**: 重要更新通知

---

## 🎉 恭喜！

按照以上步骤，你的 Fieldnote Lite 就可以成功发布了！

**推荐发布顺序**：
1. 先发布到 GitHub Releases（测试分发）
2. 收集用户反馈，修复问题
3. 稳定后发布到 PyPI
4. 考虑打包可执行文件供非技术用户使用

