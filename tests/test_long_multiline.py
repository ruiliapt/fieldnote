"""
测试长句自动分行功能
"""
from exporter import TextFormatter

# 测试长句（14个词，应该分成两行）
long_entry = {
    'id': 1,
    'example_id': 'LONG',
    'source_text': 'mɔ²¹kɯ²⁴ nɛ⁵⁵, niɔ³³ a³³ yɯ²¹ tsoŋ³³ tsaŋ²¹ je⁵⁵ ty³³ to³³ ty³³ po³³ to²¹ ha³⁵.',
    'gloss': 'that.moment TOP PROSP take PURP plant see 3.PL obtain can obtain NEG can REP',
    'translation': "At that time, it is said that (they) would take (some rice seedlings) to plant to see whether they could produce grain.",
    'notes': 'Rice cultivation trial, text'
}

# 测试中等长度（8个词）
medium_entry = {
    'id': 2,
    'example_id': 'MEDIUM',
    'source_text': 'ŋo³³ a²¹ ta⁵⁵ je²¹-xu⁵⁵ xa³³ kʰu²¹ tɕie⁵⁵ ja²¹/kua³³.',
    'gloss': '1.SG also with 3.SG-PL say several CLF EXP',
    'translation': "I've talked with them a little.",
    'notes': ''
}

print("=" * 100)
print("测试长句自动分行功能（每行最多10个词）")
print("=" * 100)
print()

print("示例1：长句（14个词）- 应该分成2行")
print("-" * 100)
formatted = TextFormatter.format_entry(long_entry, show_numbering=True, max_words_per_line=10)
print(formatted)
print()
print()

print("示例2：中等句子（8个词）- 应该在1行")
print("-" * 100)
formatted2 = TextFormatter.format_entry(medium_entry, show_numbering=True, max_words_per_line=10)
print(formatted2)
print()
print()

print("示例3：调整每行词数为6个")
print("-" * 100)
formatted3 = TextFormatter.format_entry(long_entry, show_numbering=True, max_words_per_line=6)
print(formatted3)
print()

