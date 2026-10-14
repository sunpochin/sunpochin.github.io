#!/usr/bin/env bash
# scripts/check-brand.sh - 全站品牌正名、網域與靜態資源一致性檢查工具
#
# 為何需要此腳本：
# 避免在跨頁面修改後遺漏舊品牌名（如「家簡錄」）或舊網域（jia-jian-log.vercel.app）。
# 同時取代人工 grep 漫長比對，使 Agent 與開發者能在 1 秒內完成自動化驗證。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

ERRORS=0

echo "🔍 開始執行全站品牌與資產一致性檢查..."
echo "============================================================"

# 1. 檢查是否殘留過期中文品牌名「家簡錄」
# 為何排除 TECHNICAL.md：TECHNICAL.md 第 10 節詳細記載了由「家簡錄」更名為「家健錄」的歷史決策脈絡，屬合規保留紀錄。
DEPRECATED_BRAND_MATCHES=$(grep -rn "家簡錄" . \
  --exclude-dir=".git" \
  --exclude-dir="node_modules" \
  --exclude="TECHNICAL.md" \
  --exclude="check-brand.sh" \
  --exclude="fast-replace.sh" || true)

if [[ -n "$DEPRECATED_BRAND_MATCHES" ]]; then
  echo "❌ 發現殘留舊品牌名稱「家簡錄」（應正名為「家健錄」）："
  echo "$DEPRECATED_BRAND_MATCHES"
  ERRORS=$((ERRORS + 1))
else
  echo "✅ 品牌中文名稱檢查通過：全站無殘留「家簡錄」文字"
fi

# 2. 檢查是否殘留舊 Vercel 網域 jia-jian-log.vercel.app
DEPRECATED_DOMAIN_MATCHES=$(grep -rn "jia-jian-log\.vercel\.app" . \
  --exclude-dir=".git" \
  --exclude-dir="node_modules" \
  --exclude="TECHNICAL.md" \
  --exclude="check-brand.sh" \
  --exclude="fast-replace.sh" || true)

if [[ -n "$DEPRECATED_DOMAIN_MATCHES" ]]; then
  echo "❌ 發現殘留舊網域「jia-jian-log.vercel.app」（應統一為 family-health-note.vercel.app）："
  echo "$DEPRECATED_DOMAIN_MATCHES"
  ERRORS=$((ERRORS + 1))
else
  echo "✅ 服務網域檢查通過：全站無殘留 jia-jian-log.vercel.app 舊網址"
fi

# 3. 檢查 services.json 語法合法性
# 為何需要檢驗：首頁與外部導覽依賴此 JSON，若語法錯誤將導致全站卡片渲染失敗。
if python3 -m json.tool services.json > /dev/null 2>&1; then
  echo "✅ JSON 語法檢查通過：services.json 解析正常"
else
  echo "❌ JSON 語法錯誤：services.json 格式損毀"
  ERRORS=$((ERRORS + 1))
fi

# 4. 檢查關鍵靜態資源是否存在 (防止破圖)
ASSETS_TO_CHECK=(
  "assets/images/sunpochin-outdoor.jpg"
  "assets/images/sunpochin-dj.jpg"
  "favicon.svg"
  "family-health-note/index.html"
  "family-health-note/styles.css"
  "care-translate/index.html"
  "work/index.html"
)

MISSING_ASSETS=0
for asset in "${ASSETS_TO_CHECK[@]}"; do
  if [[ ! -f "$asset" ]]; then
    echo "❌ 遺失關鍵靜態資源: $asset"
    MISSING_ASSETS=$((MISSING_ASSETS + 1))
    ERRORS=$((ERRORS + 1))
  fi
done

if [[ $MISSING_ASSETS -eq 0 ]]; then
  echo "✅ 靜態關鍵資產檢查通過：所有首頁引用的圖片與主要專頁均存在"
fi

echo "============================================================"
if [[ $ERRORS -eq 0 ]]; then
  echo "🎉 全站檢查通過！沒有發現命名、網域或資源異常。"
  exit 0
else
  echo "⚠️ 發現 $ERRORS 項檢查失敗，請修復後再提交！"
  exit 1
fi
