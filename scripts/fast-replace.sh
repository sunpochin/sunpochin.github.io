#!/usr/bin/env bash
# scripts/fast-replace.sh - 全專案安全批次字串替換工具
#
# 為何使用此工具而非 AI 逐檔微操：
# 避免 AI 在大量文字或網址替換任務中陷入 view_file -> replace_file_content 的 200 步漫長迴圈。
# 為何底層使用 Python str.replace 而非 sed：
# 1. macOS 的 BSD sed (-i '') 與 Linux GNU sed (-i) 語法不相容，容易引發跨平台錯誤。
# 2. sed 在處理包含斜線 (如 URL https://...) 或特殊符號時容易引發 delimiter 衝突或正則轉義錯誤。
# 3. Python 的字串字面量替換 (literal replace) 保證 100% 精準且不會受正則特殊字元干擾。

set -euo pipefail

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
  shift
fi

if [[ $# -lt 2 ]]; then
  echo "用法: $0 [--dry-run] <搜尋字串> <替換字串> [檔案副檔名過濾，預設: html,css,json,js,md]"
  echo "範例: $0 'jia-jian-log' 'family-health-note'"
  echo "範例 (僅預覽): $0 --dry-run '家簡錄' '家健錄'"
  exit 1
fi

SEARCH_STR="$1"
REPLACE_STR="$2"
EXTENSIONS="${3:-html,css,json,js,md}"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# 透過 Python 執行跨平台、免轉義的純字面量字串安全替換
python3 - "$SEARCH_STR" "$REPLACE_STR" "$EXTENSIONS" "$DRY_RUN" << 'EOF'
import sys
import os

search_str = sys.argv[1]
replace_str = sys.argv[2]
extensions = set(ext.strip().lstrip('.') for ext in sys.argv[3].split(','))
dry_run = sys.argv[4].lower() == 'true'

if not search_str:
    print("錯誤：搜尋字串不可為空", file=sys.stderr)
    sys.exit(1)

matched_files = 0
total_occurrences = 0

# 排除版本控制與編譯快取目錄，避免破壞內部資料
EXCLUDED_DIRS = {'.git', '.claude', '.agents', '.code-review-graph', 'node_modules'}

for root, dirs, files in os.walk('.'):
    dirs[:] = [d for d in dirs if d not in EXCLUDED_DIRS]
    for file in files:
        ext = file.split('.')[-1].lower() if '.' in file else ''
        if ext not in extensions:
            continue
        filepath = os.path.join(root, file)
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
        except UnicodeDecodeError:
            # 略過非 UTF-8 二進位檔案
            continue

        count = content.count(search_str)
        if count > 0:
            matched_files += 1
            total_occurrences += count
            status = "[預覽匹配]" if dry_run else "[已替換]"
            print(f"{status} {filepath}: 發現 {count} 處")
            if not dry_run:
                new_content = content.replace(search_str, replace_str)
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(new_content)

print("=" * 60)
mode_text = "DRY-RUN 預覽完成" if dry_run else "替換完成"
print(f"{mode_text}：共在 {matched_files} 個檔案中找到 {total_occurrences} 處匹配")
if dry_run and total_occurrences > 0:
    print("提示：若確認無誤，請移除 --dry-run 參數正式執行。")
EOF

if [[ "$DRY_RUN" == "false" ]]; then
  echo ""
  echo "--- Git 變更概覽 (git diff --stat) ---"
  git diff --stat || true
fi
