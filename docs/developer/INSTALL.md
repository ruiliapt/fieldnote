# 安装指南

本文档详细说明如何在不同平台上安装和配置 Lite Corpus Manager。

## 系统要求

- **Python**: 3.11 或更高版本
- **操作系统**: Windows 10+, macOS 10.15+, Linux (Ubuntu 20.04+ 或同等版本)
- **内存**: 建议 4GB 以上
- **磁盘空间**: 至少 200MB

## 安装方式选择

我们提供两种安装方式：

1. **Poetry（推荐）**: 现代化的 Python 依赖管理工具，自动处理虚拟环境
2. **传统方式**: 使用 pip 和 venv，适合不想安装额外工具的用户

---

## 方法 1：使用 Poetry（推荐）

### 为什么选择 Poetry？

- ✅ 自动管理虚拟环境
- ✅ 锁定依赖版本，确保一致性
- ✅ 更好的依赖解析
- ✅ 简化项目发布流程

### 1.1 安装 Poetry

#### macOS / Linux / WSL

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

安装后，将 Poetry 添加到 PATH（通常安装脚本会自动提示）：

```bash
# 添加到 ~/.bashrc 或 ~/.zshrc
export PATH="$HOME/.local/bin:$PATH"
```

然后重新加载配置：
```bash
source ~/.bashrc  # 或 source ~/.zshrc
```

#### Windows

**使用 PowerShell（以管理员身份运行）：**
```powershell
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -
```

**或使用 pipx（推荐）：**
```powershell
# 先安装 pipx
py -m pip install --user pipx
py -m pipx ensurepath

# 安装 Poetry
pipx install poetry
```

### 1.2 验证 Poetry 安装

```bash
poetry --version
```

应该显示类似：`Poetry (version 1.7.0)`

### 1.3 安装项目依赖

```bash
# 进入项目目录
cd fieldnote

# 安装依赖（会自动创建虚拟环境）
poetry install
```

### 1.4 运行程序

```bash
# 方式1：使用 poetry run
poetry run python main.py

# 方式2：激活虚拟环境后运行
poetry shell
python main.py

# 方式3：使用启动脚本（自动处理）
./run.sh    # macOS/Linux
run.bat     # Windows
```

### 1.5 其他 Poetry 命令

```bash
# 添加新依赖
poetry add package-name

# 更新依赖
poetry update

# 查看虚拟环境信息
poetry env info

# 删除虚拟环境
poetry env remove python
```

---

## 方法 2：传统方式（pip + venv）

### 2.1 确认 Python 版本

```bash
python3 --version
# 或
python --version
```

确保版本 >= 3.11

### 2.2 创建虚拟环境

#### macOS / Linux

```bash
cd fieldnote
python3 -m venv venv
source venv/bin/activate
```

#### Windows

```cmd
cd fieldnote
python -m venv venv
venv\Scripts\activate.bat
```

### 2.3 安装依赖

```bash
pip install -r requirements.txt
```

### 2.4 运行程序

```bash
# 确保虚拟环境已激活
python main.py
```

### 2.5 退出虚拟环境

```bash
deactivate
```

---

## 故障排除

### 问题 1: Poetry 命令找不到

**解决方案**：
- 确认 Poetry 安装路径是否在 PATH 中
- 重启终端
- 查看 Poetry 安装输出的提示信息

### 问题 2: PyQt6 安装失败

**macOS**：
```bash
# 可能需要安装 Xcode Command Line Tools
xcode-select --install
```

**Linux (Ubuntu/Debian)**：
```bash
sudo apt-get install python3-pyqt6
# 或
sudo apt-get install qt6-base-dev
```

**Windows**：
- 确保安装了 Visual C++ Redistributable

### 问题 3: 权限错误（macOS/Linux）

```bash
# 给启动脚本添加执行权限
chmod +x run.sh
```

### 问题 4: 虚拟环境激活失败（Windows）

如果遇到 PowerShell 执行策略问题：

```powershell
# 以管理员身份运行 PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 问题 5: Python 版本太低

**使用 pyenv 管理多个 Python 版本：**

```bash
# 安装 pyenv
curl https://pyenv.run | bash

# 安装 Python 3.11
pyenv install 3.11.7
pyenv local 3.11.7
```

### 问题 6: 依赖冲突

**Poetry**：
```bash
# 清除缓存
poetry cache clear . --all
poetry install
```

**pip**：
```bash
# 删除虚拟环境重新创建
rm -rf venv
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

## 验证安装

运行测试脚本验证安装是否成功：

```bash
# 使用 Poetry
poetry run python test_basic.py

# 使用虚拟环境
source venv/bin/activate  # 或 Windows: venv\Scripts\activate
python test_basic.py
```

如果看到 "✓ 所有测试通过！"，说明安装成功！

---

## 卸载

### 卸载 Poetry 安装的项目

```bash
# 删除虚拟环境
poetry env remove python

# 删除项目文件
cd ..
rm -rf fieldnote
```

### 卸载传统方式安装的项目

```bash
# 删除虚拟环境和项目
cd ..
rm -rf fieldnote
```

### 卸载 Poetry 本身

```bash
curl -sSL https://install.python-poetry.org | python3 - --uninstall
```

---

## 更新项目

```bash
# 进入项目目录
cd fieldnote

# 拉取最新代码
git pull

# 更新依赖
poetry install  # 使用 Poetry
# 或
pip install -r requirements.txt  # 使用 pip
```

---

## 开发者安装

如果你想参与开发或修改代码：

```bash
# 使用 Poetry（包含开发依赖）
poetry install --with dev

# 这会额外安装：
# - pytest（测试框架）
# - black（代码格式化）
# - flake8（代码检查）
```

---

需要更多帮助？请查看 [README.md](README.md) 或提交 Issue。

