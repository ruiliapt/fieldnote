# 快速开始指南

## 5分钟上手 Fieldnote Lite

### 1. 安装依赖（首次使用）

**推荐使用 Poetry：**
```bash
# 安装 Poetry（如果尚未安装）
curl -sSL https://install.python-poetry.org | python3 -

# 安装项目依赖
poetry install
```

**或使用传统方式：**
```bash
# 创建虚拟环境
python3 -m venv venv
source venv/bin/activate  # macOS/Linux
# 或 venv\Scripts\activate.bat  # Windows

# 安装依赖
pip install -r requirements.txt
```

详细安装说明请参考 [INSTALL.md](INSTALL.md)

### 2. 启动程序

**最简单的方式（推荐）：**
```bash
./run.sh      # macOS/Linux
run.bat       # Windows（双击或命令行运行）
```

**使用 Poetry：**
```bash
poetry run python main.py
# 或
poetry shell
python main.py
```

**使用虚拟环境：**
```bash
source venv/bin/activate  # 先激活虚拟环境
python main.py
```

### 3. 快速体验

#### 方法1：批量导入示例数据
1. 启动程序后，进入"数据管理"标签页
2. 点击"批量导入"按钮
3. 选择 `sample_data.json` 文件
4. 确认导入成功

#### 方法2：手动输入一条语料
1. 在"数据管理"标签页填写：
   - **例句编号**: TEST001
   - **原文**: 你好
   - **词汇分解**: hello
   - **翻译**: Hello
   - **备注**: 测试数据
2. 点击"添加语料"

### 4. 测试检索功能
1. 切换到"检索"标签页
2. 在关键词框输入"你"
3. 点击"搜索"
4. 查看搜索结果

### 5. 导出Word文档
1. 切换到"导出"标签页
2. 调整导出参数（或使用默认值）
3. 点击"导出到Word"
4. 选择保存位置
5. 用Microsoft Word或WPS打开查看

### 6. 编辑和删除
1. 回到"数据管理"标签页
2. 在表格中点击任意一行
3. 数据会自动加载到输入框
4. 修改后点击"更新语料"
5. 或点击"删除语料"删除该条记录

---

## 常用快捷操作

### 数据录入技巧
- 支持 **Tab键** 在输入框间切换
- 支持 **Ctrl+Enter** 快速提交（计划中）
- 可以直接粘贴含有IPA符号的文本

### 检索技巧
- 使用"全部字段"可以同时搜索所有内容
- 搜索不区分大小写
- 支持部分匹配（如搜索"天气"可以找到"今天天气很好"）

### 导出技巧
- 可以先检索，然后勾选"仅导出搜索结果"
- 调整字体大小适应不同打印需求
- 表格宽度建议保持在4-6英寸之间

---

## 文件说明

- `corpus.db` - 数据库文件（自动创建，包含所有语料）
- `sample_data.json` - JSON格式示例数据
- `sample_data.csv` - CSV格式示例数据
- `requirements.txt` - Python依赖列表

---

## 推荐工作流程

### 田野调查场景
1. **现场记录** → 用纸笔或录音记录原始数据
2. **整理录入** → 回到实验室后，使用本工具逐条录入
3. **标注分析** → 添加词汇分解和语法注释
4. **检索验证** → 使用检索功能查找相似例句
5. **论文写作** → 导出Word文档插入论文

### 语料库建设场景
1. **批量导入** → 从其他格式转换为JSON/CSV后批量导入
2. **逐条校对** → 使用表格浏览和编辑功能校对
3. **分类检索** → 按不同语法现象检索
4. **分批导出** → 按主题或章节分批导出

---

## 下一步

- 📖 阅读完整的 [README.md](README.md) 了解更多功能
- 💾 定期备份 `corpus.db` 文件
- 🎨 根据需要调整导出参数
- 🔧 如遇问题，查看README中的"常见问题"部分

**祝使用愉快！**

