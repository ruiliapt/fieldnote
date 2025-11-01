"""
测试长句子的对齐效果
"""
from exporter import TextFormatter

# 测试短句
short_entry = {
    'id': 1,
    'example_id': 'SHORT',
    'source_text': 'ŋo³³ a²¹ ta⁵⁵ je²¹-xu⁵⁵',
    'gloss': '1.SG also with 3.SG-PL',
    'translation': '我也和他们',
    'notes': ''
}

# 测试中等长度句子
medium_entry = {
    'id': 2,
    'example_id': 'MEDIUM',
    'source_text': 'ŋo³³ a²¹ ta⁵⁵ je²¹-xu⁵⁵ xa³³ kʰu²¹ tɕie⁵⁵ ja²¹/kua³³.',
    'gloss': '1.SG also with 3.SG-PL say several CLF EXP',
    'translation': "I've talked with them a little.",
    'notes': ''
}

# 测试长句子（15个词）
long_entry = {
    'id': 3,
    'example_id': 'LONG',
    'source_text': 'ŋo³³ a²¹ ta⁵⁵ je²¹-xu⁵⁵ xa³³ kʰu²¹ tɕie⁵⁵ ja²¹ tsʰɿ⁵⁵ kuɔ³³ ʂɿ⁵⁵ ti⁵⁵ sɿ³³ ʈʂʰɿ²¹ lɛ²¹',
    'gloss': '1.SG also with 3.SG-PL say several CLF thing this kind matter all finish PART',
    'translation': 'I also talked with them about all these kinds of matters.',
    'notes': '长句示例'
}

# 测试超长句子（20个词）
very_long_entry = {
    'id': 4,
    'example_id': 'VERYLONG',
    'source_text': 'ŋo³³ tʂɿ²¹ tau⁵⁵ ŋo³³ a²¹ ta⁵⁵ je²¹-xu⁵⁵ xa³³ kʰu²¹ tɕie⁵⁵ ja²¹ tsʰɿ⁵⁵ kuɔ³³ ʂɿ⁵⁵ ti⁵⁵ sɿ³³ ʈʂʰɿ²¹ lɛ²¹ ti⁵⁵ tʰai⁵⁵ xuɔ³³ ʂɛ⁵⁵',
    'gloss': '1SG know until 1SG also with 3SG-PL say several CLF thing this kind matter all finish PART ADV much good',
    'translation': 'I know that I also talked with them about all these kinds of matters very well.',
    'notes': '超长句示例'
}

print("=" * 120)
print("短句效果（4个词）")
print("=" * 120)
print(TextFormatter.format_entry(short_entry))
print()

print("=" * 120)
print("中等长度句子（8个词）")
print("=" * 120)
print(TextFormatter.format_entry(medium_entry))
print()

print("=" * 120)
print("长句效果（15个词）")
print("=" * 120)
print(TextFormatter.format_entry(long_entry))
print()

print("=" * 120)
print("超长句效果（20个词）")
print("=" * 120)
print(TextFormatter.format_entry(very_long_entry))
print()

# 显示实际行长度
def show_line_length(entry):
    formatted = TextFormatter.format_entry(entry, show_numbering=False)
    lines = formatted.strip().split('\n')
    if len(lines) >= 2:
        source_line = lines[0].strip()
        gloss_line = lines[1].strip()
        return len(source_line), len(gloss_line)
    return 0, 0

print("=" * 120)
print("行长度统计")
print("=" * 120)
entries = [
    ("短句", short_entry),
    ("中等", medium_entry),
    ("长句", long_entry),
    ("超长", very_long_entry)
]

for name, entry in entries:
    src_len, gls_len = show_line_length(entry)
    max_len = max(src_len, gls_len)
    print(f"{name:8s}: 原文={src_len:3d}字符, 注释={gls_len:3d}字符, 最长={max_len:3d}字符")
    if max_len > 100:
        print(f"         ⚠️ 行太长，可能需要水平滚动查看")
    print()

