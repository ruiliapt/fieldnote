"""
测试Word导出功能（透明表格）
"""
from exporter import WordExporter

# 测试数据
test_entries = [
    {
        'id': 1,
        'example_id': 'CJ001',
        'source_text': 'ŋo³³ a²¹ ta⁵⁵ je²¹-xɯ⁵⁵ xa³³ kʰɯ²¹ tɕie⁵⁵ ja²¹/kua³³.',
        'gloss': '1.SG also with 3.SG-PL say several CLF EXP',
        'translation': "I've talked with them a little.",
        'notes': 'The drowning persons, text'
    },
    {
        'id': 2,
        'example_id': 'CJ002',
        'source_text': '我 昨天 去 了 北京',
        'gloss': '1SG yesterday go PERF Beijing',
        'translation': '我昨天去了北京',
        'notes': '完成体标记'
    },
    {
        'id': 3,
        'example_id': 'CJ003',
        'source_text': '今天 天气 很 好',
        'gloss': 'today weather very good',
        'translation': '今天天气很好',
        'notes': ''
    }
]

print("=" * 80)
print("测试Word导出功能（透明表格）")
print("=" * 80)
print()

exporter = WordExporter()
output_file = "test_transparent_table_export.docx"

print(f"正在导出 {len(test_entries)} 条语料到 {output_file}...")
print()

success = exporter.export(
    entries=test_entries,
    output_path=output_file,
    show_numbering=True
)

if success:
    print("✅ 导出成功！")
    print()
    print("生成的Word文档特性：")
    print("  • 每个词占一个独立的表格单元格")
    print("  • 表格边框完全透明（无边框线）")
    print("  • 原文和注释词对词垂直对齐")
    print("  • 翻译显示在表格下方")
    print("  • 编号格式：(CJ001)")
    print()
    print(f"请打开文件查看效果：{output_file}")
    print()
    print("预期效果：")
    print("-" * 80)
    print("(CJ001)")
    print("ŋo³³  a²¹   ta⁵⁵  je²¹-xɯ⁵⁵  xa³³  kʰɯ²¹   tɕie⁵⁵  ja²¹/kua³³.")
    print("1.SG  also  with  3.SG-PL    say   several  CLF     EXP")
    print("    'I've talked with them a little.'")
    print("    (The drowning persons, text)")
    print("-" * 80)
    print()
    print("注意：在Word中看起来应该像纯文本，但实际上是透明表格。")
    print("      每个词都可以独立选择、编辑，且完美对齐。")
else:
    print("❌ 导出失败！")

