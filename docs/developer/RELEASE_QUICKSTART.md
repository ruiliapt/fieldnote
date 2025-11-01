# 快速发布指南

## 🚀 一键发布（推荐）

```bash
# 运行交互式发布向导
./release.sh

# 或使用 make
make release
```

这个脚本会自动完成：
- ✅ 运行测试
- ✅ 更新版本号
- ✅ 提示更新 CHANGELOG
- ✅ 提交更改并创建 Git 标签
- ✅ 构建分发包
- ✅ 可选：发布到 PyPI
- ✅ 推送到 GitHub

---

## 📦 手动发布步骤

### 1. 更新版本号

```bash
# 查看当前版本
make version

# 修订版本 (0.1.0 → 0.1.1)
make version-patch

# 次版本 (0.1.0 → 0.2.0)
make version-minor

# 主版本 (0.1.0 → 1.0.0)
make version-major
```

### 2. 更新 CHANGELOG.md

在 `CHANGELOG.md` 中记录更新内容。

### 3. 提交更改

```bash
git add .
git commit -m "Release v0.1.0"
git tag -a v0.1.0 -m "Release v0.1.0"
```

### 4. 发布到 PyPI

```bash
# 测试环境（推荐先测试）
make publish-test

# 正式环境
make publish
```

### 5. 推送到 GitHub

```bash
git push
git push origin v0.1.0
```

### 6. 创建 GitHub Release

1. 访问: https://github.com/yourusername/fieldnote/releases/new
2. 选择标签: `v0.1.0`
3. 填写发布说明（参考 CHANGELOG）
4. 上传可执行文件（如果有）
5. 发布

---

## 💻 构建可执行文件

### macOS/Linux

```bash
# 构建
make build-exe

# 或
./build_executable.sh

# 创建分发包
cd dist
tar -czf Fieldnote-$(uname -s)-$(uname -m).tar.gz Fieldnote/
```

### Windows

```cmd
build_executable.bat
```

---

## 📋 常用命令速查

| 命令 | 说明 |
|------|------|
| `make help` | 显示所有可用命令 |
| `make version` | 查看当前版本 |
| `make test` | 运行测试 |
| `make build` | 构建分发包 |
| `make build-exe` | 构建可执行文件 |
| `make publish-test` | 发布到 TestPyPI |
| `make publish` | 发布到 PyPI |
| `make release` | 交互式发布向导 |

---

## 🔑 配置 PyPI Token

为了避免每次发布都输入密码，可以配置 API token：

```bash
# 1. 在 PyPI 生成 token
# 访问: https://pypi.org/manage/account/token/

# 2. 配置 token
poetry config pypi-token.pypi pypi-YOUR_TOKEN_HERE

# 3. 对于 TestPyPI
poetry config pypi-token.testpypi pypi-YOUR_TEST_TOKEN_HERE
```

---

## 🎯 发布检查清单

发布前确认：

- [ ] 所有功能正常工作
- [ ] 测试通过 (`make test`)
- [ ] 代码已格式化 (`make format`)
- [ ] 无 lint 错误 (`make lint`)
- [ ] 版本号已更新
- [ ] CHANGELOG.md 已更新
- [ ] README.md 信息准确
- [ ] 提交信息清晰
- [ ] Git 标签已创建

---

## 📚 详细文档

查看 [PUBLISHING.md](PUBLISHING.md) 获取完整的发布指南。

