"""
基础功能测试脚本
用于验证数据库和导出功能是否正常工作
"""
import os
from database import CorpusDatabase
from exporter import WordExporter


def test_database():
    """测试数据库功能"""
    print("=" * 50)
    print("测试数据库功能")
    print("=" * 50)
    
    # 创建测试数据库
    test_db = "test_corpus.db"
    if os.path.exists(test_db):
        os.remove(test_db)
    
    db = CorpusDatabase(test_db)
    
    # 测试插入
    print("\n1. 测试插入数据...")
    entry_id = db.insert_entry(
        example_id="TEST001",
        source_text="ŋa˧ tə˥ tɕʰi˥ fan˨˩",
        gloss="1SG CLF eat rice",
        translation="我吃饭",
        notes="测试数据"
    )
    print(f"   ✓ 插入成功，ID: {entry_id}")
    
    # 测试查询
    print("\n2. 测试查询数据...")
    entry = db.get_entry(entry_id)
    assert entry is not None, "查询失败"
    assert entry['source_text'] == "ŋa˧ tə˥ tɕʰi˥ fan˨˩", "数据不匹配"
    print(f"   ✓ 查询成功: {entry['source_text']}")
    
    # 测试更新
    print("\n3. 测试更新数据...")
    success = db.update_entry(
        entry_id=entry_id,
        example_id="TEST001",
        source_text="ŋa˧ tə˥ tɕʰi˥ fan˨˩ lau˧",
        gloss="1SG CLF eat rice PERF",
        translation="我吃了饭",
        notes="测试更新"
    )
    assert success, "更新失败"
    print("   ✓ 更新成功")
    
    # 测试搜索
    print("\n4. 测试搜索功能...")
    results = db.search_entries("source_text", "fan")
    assert len(results) > 0, "搜索失败"
    print(f"   ✓ 搜索成功，找到 {len(results)} 条结果")
    
    # 测试批量导入
    print("\n5. 测试批量导入...")
    entries = [
        {
            "example_id": "TEST002",
            "source_text": "测试文本2",
            "gloss": "test gloss 2",
            "translation": "测试翻译2",
            "notes": ""
        },
        {
            "example_id": "TEST003",
            "source_text": "测试文本3",
            "gloss": "test gloss 3",
            "translation": "测试翻译3",
            "notes": ""
        }
    ]
    count = db.import_from_list(entries)
    print(f"   ✓ 批量导入成功，导入 {count} 条")
    
    # 测试统计
    print("\n6. 测试统计功能...")
    total = db.get_count()
    print(f"   ✓ 数据库总计: {total} 条语料")
    
    db.close()
    
    # 清理测试数据库
    if os.path.exists(test_db):
        os.remove(test_db)
    
    print("\n✓ 数据库功能测试通过！")
    return True


def test_exporter():
    """测试导出功能"""
    print("\n" + "=" * 50)
    print("测试导出功能")
    print("=" * 50)
    
    # 创建测试数据
    print("\n1. 准备测试数据...")
    test_entries = [
        {
            "example_id": "EXP001",
            "source_text": "ŋa˧ tə˥ tɕʰi˥ fan˨˩",
            "gloss": "1SG CLF eat rice",
            "translation": "我吃饭",
            "notes": "测试导出"
        },
        {
            "example_id": "EXP002",
            "source_text": "ni˧ kʰɤ˥ na˧ li˥",
            "gloss": "2SG go where",
            "translation": "你去哪里",
            "notes": ""
        }
    ]
    print(f"   ✓ 准备了 {len(test_entries)} 条测试数据")
    
    # 测试导出
    print("\n2. 测试Word导出...")
    exporter = WordExporter()
    output_path = "test_export.docx"
    
    success = exporter.export(
        entries=test_entries,
        output_path=output_path,
        table_width=5.0,
        font_size=10,
        line_spacing=1.15,
        show_numbering=True
    )
    
    assert success, "导出失败"
    assert os.path.exists(output_path), "导出文件未创建"
    print(f"   ✓ 导出成功: {output_path}")
    
    # 清理测试文件
    if os.path.exists(output_path):
        os.remove(output_path)
        print("   ✓ 清理测试文件")
    
    print("\n✓ 导出功能测试通过！")
    return True


def main():
    """主测试函数"""
    print("\n" + "=" * 50)
    print("Lite Corpus Manager - 功能测试")
    print("=" * 50)
    
    try:
        # 测试数据库
        test_database()
        
        # 测试导出
        test_exporter()
        
        print("\n" + "=" * 50)
        print("✓ 所有测试通过！")
        print("=" * 50)
        print("\n程序功能正常，可以运行 main.py 启动图形界面。")
        
    except Exception as e:
        print(f"\n✗ 测试失败: {str(e)}")
        import traceback
        traceback.print_exc()
        return False
    
    return True


if __name__ == "__main__":
    main()

