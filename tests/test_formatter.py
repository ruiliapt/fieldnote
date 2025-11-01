"""
测试格式化输出效果
"""
from exporter import TextFormatter

# 测试数据 - 模仿你提供的示例
test_entry = {
    'id': 1,
    'example_id': '10',
    'source_text': 'ŋo³³ a²¹ ta⁵⁵ je²¹-xu⁵⁵ xa³³ kʰu²¹ tɕie⁵⁵ ja²¹/kua³³.',
    'gloss': '1.SG also with 3.SG-PL say several CLF EXP',
    'translation': "I've talked with them a little.",
    'notes': 'The drowning persons, text; kua³³: Elicitation'
}

# 测试中文示例
test_entry_chinese = {
    'id': 2,
    'example_id': 'CJ001',
    'source_text': '我 昨天 去 了 北京',
    'gloss': '1SG yesterday go PERF Beijing',
    'translation': '我昨天去了北京',
    'notes': '完成体标记'
}

# 测试混合示例
test_entry_mixed = {
    'id': 3,
    'example_id': '3',
    'source_text': '今天 天气 很 好',
    'gloss': 'today weather very good',
    'translation': '今天天气很好',
    'notes': ''
}

print("=" * 80)
print("格式化输出测试")
print("=" * 80)
print()

print("示例 1: 带上标音调标记的IPA")
print("-" * 80)
formatted1 = TextFormatter.format_entry(test_entry, show_numbering=True)
print(formatted1)
print()
print()

print("示例 2: 中英混合")
print("-" * 80)
formatted2 = TextFormatter.format_entry(test_entry_chinese, show_numbering=True)
print(formatted2)
print()
print()

print("示例 3: 中文原文英文注释")
print("-" * 80)
formatted3 = TextFormatter.format_entry(test_entry_mixed, show_numbering=True)
print(formatted3)
print()
print()

print("=" * 80)
print("批量格式化测试")
print("=" * 80)
print()
entries = [test_entry, test_entry_chinese, test_entry_mixed]
formatted_all = TextFormatter.format_entries(entries, show_numbering=True)
print(formatted_all)

