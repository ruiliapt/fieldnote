# Fieldnotes Lite - 项目结构速览

```
fieldnote/                           # 项目根目录
│
├── 📄 核心代码 (4个Python文件)
│   ├── main.py                      # 程序入口
│   ├── gui.py                       # 图形界面
│   ├── database.py                  # 数据库操作
│   └── exporter.py                  # Word导出
│
├── 📚 docs/ - 所有文档
│   ├── user/                        # 用户文档 (3个)
│   │   ├── ONE_PAGE_GUIDE.md       # ⭐ 快速指南
│   │   ├── USER_GUIDE_NON_TECHNICAL.md  # ⭐ 详细教程
│   │   └── README_DISTRIBUTION.md   # 分发指南
│   │
│   ├── developer/                   # 开发者文档 (12个)
│   │   ├── QUICKSTART.md
│   │   ├── INSTALL.md
│   │   ├── PROJECT_OVERVIEW.md
│   │   ├── PUBLISHING.md
│   │   ├── CHANGELOG.md
│   │   └── ...
│   │
│   ├── guides/                      # 使用指南 (2个)
│   │   ├── EXPORT_FORMAT_GUIDE.md
│   │   └── ALIGNMENT_TIPS.md
│   │
│   ├── README.md                    # 文档主页
│   ├── DOCS_INDEX.md               # 文档索引
│   └── REORGANIZATION_SUMMARY.md   # 重组总结
│
├── 🛠️ scripts/ - 所有脚本
│   ├── build_executable.sh/.bat    # 构建脚本
│   ├── run.sh/.bat                 # 运行脚本
│   ├── stop.sh/.bat                # 停止脚本
│   ├── release.sh                  # 发布脚本
│   └── 启动Fieldnotes.command       # macOS快捷启动
│
├── 🧪 tests/ - 所有测试
│   ├── test_basic.py
│   ├── test_formatter.py
│   ├── test_word_export.py
│   └── ...  (5个测试文件)
│
├── 📋 samples/ - 示例数据
│   ├── sample_data.json
│   ├── sample_data_linguistic.json
│   └── sample_data.csv
│
├── 📦 dist/ - 构建产物
│   ├── Fieldnotes.app               # macOS应用
│   ├── *.tar.gz                    # 分发包
│   └── 文档副本
│
└── 📝 配置文件
    ├── README.md                    # 项目说明
    ├── LICENSE                      # 许可证
    ├── pyproject.toml              # Poetry配置
    ├── requirements.txt            # 依赖列表
    ├── Makefile                    # 任务命令
    ├── .gitignore                  # Git忽略
    ├── PROJECT_STRUCTURE.md        # 结构详细说明
    └── STRUCTURE_QUICK_VIEW.md     # 本文件
```

## 快速导航

### 我是用户（不懂编程）
👉 [一页纸快速指南](docs/user/ONE_PAGE_GUIDE.md)  
👉 [详细使用教程](docs/user/USER_GUIDE_NON_TECHNICAL.md)

### 我是开发者
👉 [快速开始](docs/developer/QUICKSTART.md)  
👉 [项目概览](docs/developer/PROJECT_OVERVIEW.md)  
👉 [完整结构说明](PROJECT_STRUCTURE.md)

### 我想了解某个功能
👉 [导出格式说明](docs/guides/EXPORT_FORMAT_GUIDE.md)  
👉 [对齐技巧](docs/guides/ALIGNMENT_TIPS.md)

### 查看所有文档
👉 [文档索引](docs/DOCS_INDEX.md)

## 常用命令

```bash
make run        # 运行程序
make test       # 运行测试
make build-exe  # 构建可执行文件
make clean      # 清理临时文件
make help       # 查看所有命令
```

---

**整理完成日期**: 2025-10-20  
**版本**: 0.1.0
