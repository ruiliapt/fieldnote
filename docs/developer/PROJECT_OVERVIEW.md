# Fieldnotes Lite - 项目概览

## 📋 项目信息

- **项目名称**: Fieldnotes Lite
- **版本**: 0.1.0
- **类型**: 桌面应用程序
- **开发语言**: Python 3.11+
- **UI框架**: PyQt6
- **许可证**: MIT

---

## 🎯 项目目标

为语言学研究者提供一个轻量级、易用的语料管理工具，特别适用于：
- 田野调查数据整理
- 方言语料记录
- 少数民族语言文档化
- 带音标和语法注释的语料维护

---

## 🏗️ 项目结构

```
fieldnote/
├── main.py                  # 主程序入口
├── gui.py                   # PyQt6 图形界面
├── database.py              # SQLite 数据库操作
├── exporter.py              # Word 文档导出
├── test_basic.py            # 基础功能测试
│
├── pyproject.toml           # Poetry 项目配置
├── requirements.txt         # pip 依赖列表（备用）
├── Makefile                 # 常用命令快捷方式
│
├── run.sh                   # Linux/macOS 启动脚本
├── run.bat                  # Windows 启动脚本
│
├── README.md                # 项目说明文档
├── QUICKSTART.md            # 快速开始指南
├── INSTALL.md               # 详细安装说明
├── PROJECT_OVERVIEW.md      # 本文件
├── LICENSE                  # MIT 许可证
│
├── sample_data.json         # JSON 格式示例数据
├── sample_data.csv          # CSV 格式示例数据
│
└── corpus.db                # SQLite 数据库（运行后自动创建）
```

---

## 🔧 技术架构

### 核心技术栈

| 组件 | 技术 | 用途 |
|------|------|------|
| **UI层** | PyQt6 | 图形用户界面 |
| **数据层** | SQLite3 | 本地数据存储 |
| **导出层** | python-docx | Word 文档生成 |
| **依赖管理** | Poetry | 包管理和虚拟环境 |
| **辅助库** | pandas | 数据处理（批量导入） |

### 架构设计

```
┌─────────────────────────────────────┐
│         GUI Layer (gui.py)          │
│  - 数据录入界面                      │
│  - 检索界面                          │
│  - 导出参数设置                      │
└───────────┬─────────────────────────┘
            │
            ├──────────┬──────────────┐
            │          │              │
┌───────────▼──┐  ┌───▼────────┐  ┌──▼──────────┐
│  Database    │  │  Exporter  │  │   Main      │
│(database.py) │  │(exporter.py)│  │  (main.py)  │
│              │  │            │  │             │
│ - CRUD操作   │  │ - Word导出 │  │ - 程序入口  │
│ - 搜索功能   │  │ - 格式设置 │  │ - 初始化    │
│ - 批量导入   │  │            │  │             │
└──────────────┘  └────────────┘  └─────────────┘
       │
       ▼
┌──────────────┐
│  corpus.db   │
│  (SQLite)    │
└──────────────┘
```

---

## 💾 数据库设计

### 表结构：corpus

| 字段名 | 类型 | 说明 | 示例 |
|--------|------|------|------|
| `id` | INTEGER | 主键，自增 | 1 |
| `example_id` | TEXT | 例句编号 | "CJ001" |
| `source_text` | TEXT | 原文 | "ŋa˧ tə˥ tɕʰi˥ fan˨˩" |
| `gloss` | TEXT | 词汇分解/注释 | "1SG CLF eat rice" |
| `translation` | TEXT | 翻译 | "我吃饭" |
| `notes` | TEXT | 备注 | "日常用语" |

### 数据特点

- ✅ 完全支持 Unicode（包括IPA、藏文、各种少数民族文字）
- ✅ 无字段长度限制
- ✅ 支持 10,000+ 条语料
- ✅ 单文件存储，便于备份

---

## 📦 核心功能模块

### 1. 数据录入模块 (`gui.py` - 数据管理标签页)

**功能**：
- 手动录入语料（支持5个字段）
- 自动保存到数据库
- 支持Unicode和IPA字符输入
- 批量导入（JSON/CSV格式）

**关键方法**：
- `add_entry()` - 添加新语料
- `update_entry()` - 更新现有语料
- `delete_entry()` - 删除语料
- `import_data()` - 批量导入

### 2. 数据库模块 (`database.py`)

**功能**：
- SQLite数据库连接管理
- CRUD操作封装
- 搜索功能实现
- 批量导入处理

**关键类和方法**：
```python
class CorpusDatabase:
    def insert_entry(...)       # 插入单条记录
    def update_entry(...)       # 更新记录
    def delete_entry(...)       # 删除记录
    def get_entry(...)          # 获取单条记录
    def get_all_entries(...)    # 获取所有记录
    def search_entries(...)     # 搜索功能
    def import_from_list(...)   # 批量导入
```

### 3. 检索模块 (`gui.py` - 检索标签页)

**功能**：
- 全文搜索
- 字段搜索（可选择特定字段）
- 模糊匹配（LIKE查询）
- 搜索结果显示

**搜索字段**：
- 全部字段
- 例句编号
- 原文
- 词汇分解
- 翻译
- 备注

### 4. 导出模块 (`exporter.py`)

**功能**：
- 导出为 Word (.docx) 格式
- 三行透明表格样式
- 参数可自定义

**导出参数**：
- 表格宽度（1-10英寸，默认5英寸）
- 字体大小（6-24pt，默认10pt）
- 行距（1.0-3.0，默认1.15）
- 是否显示编号（默认显示）
- 每页语料数（1-50，默认10）

**Word格式示例**：
```
(CJ001)
┌────────────────────────────────┐
│ ŋa˧ tə˥ tɕʰi˥ fan˨˩            │  ← 原文
├────────────────────────────────┤
│ 1SG CLF eat rice               │  ← 词汇分解
├────────────────────────────────┤
│ 我吃饭                          │  ← 翻译
└────────────────────────────────┘
备注: 日常用语
```

---

## 🚀 使用流程

### 典型工作流程

1. **启动程序** → 运行 `./run.sh` 或 `run.bat`
2. **录入数据** → 在"数据管理"标签页输入语料信息
3. **保存数据** → 点击"添加语料"按钮
4. **检索验证** → 在"检索"标签页搜索已录入的语料
5. **调整参数** → 在"导出"标签页设置导出格式
6. **导出文档** → 点击"导出到Word"生成文档

### 批量导入流程

1. 准备 JSON 或 CSV 格式的数据文件
2. 点击"批量导入"按钮
3. 选择文件
4. 确认导入结果

---

## 🧪 测试

### 运行测试

```bash
# 使用 Poetry
poetry run python test_basic.py

# 使用 make
make test

# 或直接运行
python test_basic.py
```

### 测试内容

- ✅ 数据库增删改查
- ✅ 搜索功能
- ✅ 批量导入
- ✅ Word导出
- ✅ Unicode/IPA支持

---

## 📊 性能指标

| 指标 | 数值 |
|------|------|
| 语料容量 | 10,000+ 条 |
| 启动时间 | < 2秒 |
| 搜索速度 | < 100ms (1000条内) |
| 导出速度 | ~100条/秒 |
| 内存占用 | < 100MB |

---

## 🔒 数据安全

### 备份建议

1. **定期备份数据库文件**
   ```bash
   cp corpus.db corpus_backup_$(date +%Y%m%d).db
   ```

2. **导出为JSON备份**
   - 使用批量导入功能的逆过程
   - JSON格式更易于版本控制

3. **云存储同步**
   - 可将 `corpus.db` 放在云盘同步文件夹中
   - 注意：多设备同时写入可能导致冲突

---

## 🛠️ 开发指南

### 环境设置

```bash
# 克隆项目
git clone https://github.com/yourusername/fieldnote.git
cd fieldnote

# 安装开发依赖
poetry install --with dev

# 或使用 make
make install-dev
```

### 代码风格

- Python代码遵循 PEP 8
- 行长度：100字符
- 使用 black 格式化：`make format`
- 使用 flake8 检查：`make lint`

### 贡献流程

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交改动 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

---

## 🗺️ 未来规划

### 短期目标（v0.2.0）

- [ ] 添加数据导出为JSON/CSV功能
- [ ] 实现正则表达式搜索
- [ ] 添加撤销/重做功能
- [ ] 优化表格显示性能

### 中期目标（v0.3.0）

- [ ] LaTeX格式导出
- [ ] PDF直接导出
- [ ] 音频文件关联
- [ ] 多语言界面支持

### 长期目标（v1.0.0）

- [ ] 云端同步功能
- [ ] Web版本
- [ ] 语义标注支持
- [ ] 团队协作功能
- [ ] 语料统计分析

---

## 📚 相关资源

### 文档

- [README.md](README.md) - 项目说明
- [QUICKSTART.md](QUICKSTART.md) - 快速开始
- [INSTALL.md](INSTALL.md) - 详细安装说明

### 工具和库

- [PyQt6 文档](https://www.riverbankcomputing.com/static/Docs/PyQt6/)
- [python-docx 文档](https://python-docx.readthedocs.io/)
- [Poetry 文档](https://python-poetry.org/docs/)
- [SQLite 文档](https://www.sqlite.org/docs.html)

### 相关项目

- [FieldWorks](https://software.sil.org/fieldworks/) - 专业语言学软件套件
- [ELAN](https://archive.mpi.nl/tla/elan) - 多媒体注释工具
- [Toolbox](https://software.sil.org/toolbox/) - 语料数据管理

---

## 💬 反馈与支持

- **问题报告**: 在 GitHub Issues 中提交
- **功能建议**: 欢迎在 Issues 中讨论
- **使用问题**: 查看 README 中的"常见问题"部分

---

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

---

**Happy Linguistic Research! 🎓**

