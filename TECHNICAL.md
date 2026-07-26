# TECHNICAL.md - sunpochin.github.io 技術架構與設計決策

本文件記錄 `sunpochin.github.io` 門牌首頁的技術選擇、架構設計原則與排除的替代方案。

---

## 1. 核心理念與設計目標 (Core Architecture Principles)

首頁是入口門牌，追求極致載入速度、極低維護成本與高可靠性。

* **零建置依賴 (Zero Build Tools)**：不使用 npm, webpack, Vite, Nuxt, Next.js 或 Tailwind CLI，絕不受套件版本過期、安全性漏洞修補（Renovate / Dependabot alert）騷擾。
* **行動優先 (Mobile-First)**：以 375px+ 行動裝置視圖為基準設計，搭配 Modern CSS Grid & Flexbox 自動適應平板（640px+）與桌面（1024px+）。
* **漸進增強 (Progressive Enhancement)**：HTML 內建全套語意化靜態卡片，即便使用者關閉 JavaScript 或 Fetch 遭阻擋，也能 100% 正常顯示與點擊導航。
* **數據與呈現分離 (Separation of Concerns)**：使用 `services.json` 作為服務資料點的 Single Source of Truth，Vanilla JS 於 DOM Ready 後自動抓取與同步。

---

## 2. 檔案結構 (File Structure)

```text
sunpochin.github.io/
├── index.html     # 主頁面 (HTML5 語意化 + 漸進增強骨架 + Vanilla JS)
├── styles.css     # 行動優先 Modern Glassmorphism 樣式表 (原生 CSS 變數)
├── favicon.svg    # 向量向量標誌圖示 (高畫質暗色光暈門牌 SVG)
├── services.json  # 結構化服務項目資料 (名稱、網址、說明、目標受眾、狀態標籤)
└── TECHNICAL.md   # 本架構技術說明文件
```

---

## 3. 排除的替代方案 (Rejected Alternatives)

| 替代方案 | 排除原因 (Why Rejected) |
| :--- | :--- |
| **Nuxt.js / Next.js / Astro** | 門牌首頁屬靜態展示，引進 SSR/SSG 框架會產生大量 node_modules，增加 GitHub Actions 打包時間與維護負擔。 |
| **TailwindCSS** | Tailwind 需要 Node CLI 打包或引入大型 CDN，原生 CSS 變數 (Custom Properties) 已完全能提供現代化 Token 系統與模組化。 |
| **純動態 JS 渲染 (純 Client-side Render)** | 若完全依賴 `fetch('services.json').then(render)`，在網路延遲或弱網環境下會產生 FOUT/CLS (版面跳動)，且無視覺障礙備援。故採用靜態骨架 + JS 水合 (Hydration) 雙軌制。 |
| **第三方 Icon 庫 (FontAwesome / Lucide CDN)** | 避免外部 HTTP Request 延遲與第三方 CDN 故障風險，直接採用內嵌向量 SVG path。 |

---

## 4. 服務狀態標籤定義 (Service Status Taxonomy)

* `status-active` (公開使用)：穩定運作之線上服務（亮綠色光暈呼吸燈）。
* `status-beta` (測試中)：可公開存取但仍持續修訂 feature 之服務（琥珀金光暈呼吸燈）。
* `status-dev` (開發中)：尚未開放或預備推出之服務（天空藍光暈呼吸燈）。

---

## 5. 驗證與測試 (Verification)

1. **語意結構驗證**：符合 HTML5 語意標準與 WCAG 2.1 觸控打擊區塊 (Touch Target size >= 48px) 標準。
2. **極速效能 (Lighthouse / CWV)**：無 external script 與大型圖檔，LCP (Largest Contentful Paint) < 0.5s，CLS = 0。
