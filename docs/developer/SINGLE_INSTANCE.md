# 单实例运行说明

## 功能说明

Fieldnotes Lite 使用**单实例运行机制**，防止同时启动多个程序实例。

---

## 🔒 工作原理

### 锁文件机制

程序启动时会在系统临时目录创建锁文件：
- **文件名**: `fieldnote_lite.lock`
- **位置**: 
  - macOS/Linux: `/tmp/fieldnote_lite.lock`
  - Windows: `C:\Users\YourName\AppData\Local\Temp\fieldnote_lite.lock`

### 运行逻辑

```
第一次启动 → 创建锁文件 → 程序正常运行 ✅

再次启动 → 检测到锁文件 → 显示提示对话框 ⚠️ → 退出
```

---

## ✅ 为什么是安全的

### 不会影响其他 Python 程序

锁文件名 `fieldnote_lite.lock` 是**唯一的**，即使其他项目也叫 `main.py`，它们也不会相互影响：

| 程序 | 锁文件 | 是否冲突 |
|------|--------|----------|
| Fieldnotes Lite | `/tmp/fieldnote_lite.lock` | ❌ |
| 其他项目 A | `/tmp/project_a.lock` | ❌ |
| 其他项目 B | (无锁文件机制) | ❌ |

### 自动清理

- **正常退出**: 程序自动释放锁文件
- **崩溃退出**: 系统会清理临时目录
- **手动清理**: 使用停止脚本

---

## 🛠️ 常见场景

### 场景 1: 正常使用

```bash
# 第一次启动
./run.sh          # ✅ 成功启动

# 再次启动（程序还在运行）
./run.sh          # ⚠️ 提示"程序已在运行"
```

### 场景 2: 程序崩溃后的锁文件残留

如果程序异常退出，锁文件可能残留。解决方法：

```bash
# 方法 1: 使用停止脚本（推荐）
./stop.sh         # 会自动清理锁文件

# 方法 2: 手动删除锁文件
rm /tmp/fieldnote_lite.lock

# 然后重新启动
./run.sh
```

### 场景 3: 其他 main.py 程序同时运行

```bash
# 在目录 A 中运行 Fieldnotes Lite
cd /path/to/fieldnote
./run.sh          # ✅ 正常运行

# 在目录 B 中运行其他项目
cd /path/to/other_project
python main.py    # ✅ 不受影响，正常运行
```

两个程序**互不影响**！

---

## 📋 停止程序

### 推荐方法

```bash
# macOS/Linux
./stop.sh

# Windows
stop.bat

# 或使用 make
make stop
```

这些脚本会：
1. 精确匹配当前目录的 Fieldnotes Lite 进程
2. 安全停止程序
3. 清理残留的锁文件

### 不推荐的方法

❌ **不要使用**: `pkill -f "python.*main.py"`
- 会误杀所有叫 main.py 的 Python 程序
- 可能影响其他正在运行的项目

---

## 🐛 故障排除

### 问题: 提示"程序已在运行"，但找不到窗口

**原因**: 锁文件残留

**解决**:
```bash
# 1. 检查锁文件
ls -la /tmp/fieldnote_lite.lock

# 2. 清理锁文件
./stop.sh

# 3. 重新启动
./run.sh
```

### 问题: 想要同时运行多个实例（用于测试）

**方法**: 临时禁用单实例检查

编辑 `main.py`，注释掉锁文件检查部分：
```python
# 临时禁用单实例检查（仅用于开发测试）
# if not lock_file.tryLock(100):
#     ...
```

⚠️ **警告**: 多实例可能导致数据库冲突，仅用于开发测试！

---

## 🔧 技术细节

### 实现代码

```python
from PyQt6.QtCore import QLockFile, QDir
import os

# 创建锁文件
temp_dir = QDir.tempPath()
lock_file_path = os.path.join(temp_dir, 'fieldnote_lite.lock')
lock_file = QLockFile(lock_file_path)

# 尝试获取锁
if not lock_file.tryLock(100):
    # 已有实例在运行
    show_warning_dialog()
    sys.exit(1)

# ... 程序运行 ...

# 退出时释放锁
lock_file.unlock()
```

### 优势

- ✅ 跨平台（macOS/Linux/Windows）
- ✅ 自动清理（正常退出时）
- ✅ 进程安全（使用文件锁）
- ✅ 唯一标识（特定文件名）

---

## 📚 相关文档

- [README.md](README.md) - 项目说明
- [QUICKSTART.md](QUICKSTART.md) - 快速开始

---

**Fieldnotes Lite** - 安全的单实例运行机制 🔒

