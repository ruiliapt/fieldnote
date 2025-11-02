# GitHub Actions 自动化构建指南

本文档说明如何使用 GitHub Actions 自动构建和发布 Fieldnotes Lite 的跨平台安装包。

---

## 📋 概述

我们配置了两个 GitHub Actions 工作流：

1. **`build-release.yml`** - 正式发布构建
   - 触发条件：推送版本标签（如 `v0.2.0`）
   - 功能：构建所有平台 + 创建 GitHub Release

2. **`test-build.yml`** - 测试构建
   - 触发条件：手动触发 或 PR 到 main 分支
   - 功能：仅测试构建，不创建发布

---

## 🚀 如何发布新版本

### 方法 1: 使用版本标签（推荐）⭐

```bash
# 1. 确保所有改动已提交
git add .
git commit -m "feat: 完成新功能"
git push origin main

# 2. 创建并推送版本标签
git tag v0.2.0
git push origin v0.2.0
```

**自动流程**：
1. ✅ GitHub Actions 自动触发
2. ✅ 在 Ubuntu、Windows、macOS 上分别构建
3. ✅ 生成压缩包和 SHA256 校验和
4. ✅ 自动创建 GitHub Release
5. ✅ 上传所有平台的安装包

### 方法 2: 手动触发

1. 访问 GitHub 仓库
2. 点击 **Actions** 标签
3. 选择 **Build Release** 工作流
4. 点击 **Run workflow**
5. 选择分支并运行

> ⚠️ 注意：手动触发不会创建 Release，只会构建并上传 Artifacts

---

## 🧪 如何测试构建

### 在 PR 中自动测试

创建 Pull Request 时，会自动触发测试构建，验证代码能否在所有平台上成功打包。

### 手动触发测试

```bash
# 方式1: 通过 GitHub 网页
1. 访问 GitHub 仓库
2. 点击 Actions 标签
3. 选择 "Test Build" 工作流
4. 点击 "Run workflow"
```

**构建结果**：
- Artifacts 会保存 7 天，可下载测试
- 不会创建 Release

---

## 📦 构建产物

### 文件列表

每次成功构建会生成：

```
Fieldnotes-Windows.zip           # Windows 安装包
Fieldnotes-Windows.zip.sha256    # Windows 校验和

Fieldnotes-macOS.tar.gz          # macOS 安装包
Fieldnotes-macOS.tar.gz.sha256   # macOS 校验和

Fieldnotes-Linux-x86_64.tar.gz       # Linux 安装包
Fieldnotes-Linux-x86_64.tar.gz.sha256  # Linux 校验和
```

### 大小参考

| 平台 | 压缩后大小 |
|------|------------|
| Windows | ~40 MB |
| macOS | ~50 MB |
| Linux | ~45 MB |

---

## 🔍 查看构建状态

### 1. 通过 GitHub Actions 页面

访问：`https://github.com/ruiliapt/fieldnote/actions`

可以看到：
- ✅ 成功的构建（绿色）
- ❌ 失败的构建（红色）
- 🟡 进行中的构建（黄色）

### 2. 通过 Badge（徽章）

在 README 中添加徽章显示构建状态：

```markdown
![Build Status](https://github.com/ruiliapt/fieldnote/workflows/Build%20Release/badge.svg)
```

### 3. 查看构建日志

1. 点击具体的构建任务
2. 展开各个步骤查看详细日志
3. 下载日志文件进行分析

---

## 📥 下载构建产物

### 从 GitHub Release 下载（正式发布）

访问：`https://github.com/ruiliapt/fieldnote/releases`

每个 Release 包含：
- 所有平台的安装包
- SHA256 校验文件
- 发布说明

### 从 Artifacts 下载（测试构建）

1. 进入 Actions 页面
2. 选择具体的构建任务
3. 滚动到底部的 "Artifacts" 部分
4. 点击下载对应平台的构建产物

> ⚠️ Artifacts 保存期限：
> - Test Build: 7 天
> - Release Build: 永久（通过 GitHub Release）

---

## 🔧 工作流配置详解

### build-release.yml

```yaml
触发条件:
  - 推送 v* 标签（如 v0.2.0）
  - 手动触发

构建矩阵:
  - ubuntu-latest  (Linux x86_64)
  - windows-latest (Windows x64)
  - macos-latest   (macOS Universal)

主要步骤:
  1. 检出代码
  2. 设置 Python 3.11
  3. 安装 Poetry
  4. 安装依赖
  5. 执行平台特定的构建脚本
  6. 打包为压缩文件
  7. 计算 SHA256
  8. 上传 Artifacts
  9. 创建 GitHub Release（仅标签触发时）
```

### test-build.yml

```yaml
触发条件:
  - 手动触发
  - Pull Request 到 main 分支

构建矩阵:
  - ubuntu-latest
  - windows-latest
  - macos-latest

主要步骤:
  1. 检出代码
  2. 设置 Python 3.11
  3. 安装 Poetry
  4. 安装依赖
  5. 运行测试（如有）
  6. 执行构建
  7. 验证可执行文件存在
  8. 上传 Artifacts（保留 7 天）
```

---

## 🐛 故障排查

### 构建失败

**常见原因**：

1. **依赖安装失败**
   ```
   解决：检查 pyproject.toml 和 poetry.lock 是否正确
   ```

2. **PyInstaller 打包失败**
   ```
   解决：查看具体错误日志，可能是缺少隐藏导入
   ```

3. **权限问题（macOS）**
   ```
   解决：GitHub Actions 的 macOS runner 不支持代码签名
        需要在本地 macOS 上手动签名和公证
   ```

### 查看详细日志

```bash
# 1. 点击失败的构建任务
# 2. 展开失败的步骤
# 3. 查看红色错误信息
# 4. 下载完整日志：点击右上角的齿轮图标
```

### 本地复现问题

```bash
# 在本地使用相同的命令测试
poetry install
bash scripts/build_executable.sh  # 或 .bat (Windows)
```

---

## 🔐 安全性

### Secrets 管理

**不需要额外配置**：
- `GITHUB_TOKEN` 自动提供
- 用于创建 Release 和上传 Artifacts

### 代码签名

**macOS 和 Windows** 的代码签名需要证书：

1. **macOS**: 
   - 需要 Apple Developer 证书
   - 在本地签名和公证后上传

2. **Windows**:
   - 需要代码签名证书
   - 可以使用 GitHub Actions 自动签名
   - 需要在 Secrets 中添加证书

---

## 📊 工作流监控

### 构建时间参考

| 平台 | 平均构建时间 |
|------|--------------|
| Linux | ~5-8 分钟 |
| Windows | ~8-12 分钟 |
| macOS | ~10-15 分钟 |

**总计**: ~15-20 分钟（并行构建）

### 资源使用

- **免费额度**（公开仓库）：无限制
- **私有仓库**：
  - Linux: 2000 分钟/月
  - Windows: 1000 分钟/月
  - macOS: 200 分钟/月

---

## 🎯 最佳实践

### 1. 版本管理

```bash
# 遵循语义化版本
v0.1.0  # 初始版本
v0.2.0  # 新功能
v0.2.1  # Bug 修复
v1.0.0  # 稳定版本
```

### 2. 发布前检查

- [ ] 运行所有测试
- [ ] 更新 CHANGELOG
- [ ] 更新版本号（pyproject.toml）
- [ ] 提交所有更改
- [ ] 本地测试构建
- [ ] 推送到 GitHub
- [ ] 创建并推送标签

### 3. Release Notes

每个 Release 应包含：
- 新增功能
- Bug 修复
- 破坏性更改
- 已知问题
- 安装说明

---

## 🔄 更新工作流

修改工作流文件后：

```bash
# 1. 编辑 .github/workflows/*.yml
# 2. 提交并推送
git add .github/workflows/
git commit -m "ci: 更新构建工作流"
git push origin main

# 3. 通过手动触发测试新配置
# 访问 GitHub Actions 页面手动运行
```

---

## 📚 参考资源

- [GitHub Actions 文档](https://docs.github.com/en/actions)
- [PyInstaller 文档](https://pyinstaller.org/)
- [Poetry 文档](https://python-poetry.org/)
- [语义化版本](https://semver.org/lang/zh-CN/)

---

## 🆘 获取帮助

遇到问题？

1. 查看 [GitHub Actions 日志]
2. 阅读 [常见问题](#故障排查)
3. 提交 [GitHub Issue]
4. 查看 [构建脚本](../../scripts/)

---

**最后更新**: 2025-11-02

