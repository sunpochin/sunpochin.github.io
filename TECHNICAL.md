# TECHNICAL.md - sunpochin.github.io 技術架構與設計決策

本文件記錄 `sunpochin.github.io` 門牌首頁的技術選擇、架構設計原則與排除的替代方案。

---

## 1. 核心理念與設計目標 (Core Architecture Principles)

首頁是入口門牌，追求極致載入速度、極低維護成本與高可靠性。

* **零建置依賴 (Zero Build Tools)**：不使用 npm, webpack, Vite, Nuxt, Next.js 或 Tailwind CLI，絕不受套件版本過期、安全性漏洞修補（Renovate / Dependabot alert）騷擾。
* **行動優先 (Mobile-First)**：以 375px+ 行動裝置視圖為基準設計，搭配 Modern CSS Grid & Flexbox 自動適應平板與桌面。
* **明確服務語意 (Service-First Call to Action)**：入口按鈕不直接拿裸網址替代說明，而是標示服務名稱（例如：「血壓與用藥紀錄」），讓底層網址回到純粹門牌定位。
* **漸進增強 (Progressive Enhancement)**：HTML 內建全套語意化靜態卡片，即便使用者關閉 JavaScript 或 Fetch 遭阻擋，也能 100% 正常顯示與點擊導航。
* **數據與呈現分離 (Separation of Concerns)**：使用 `services.json` 作為服務資料點的 Single Source of Truth。

---

## 2. 目前已啟用之服務門牌 (Active Services)

1. **血壓與用藥紀錄** (`https://bp-722.vercel.app`) - 公開使用
2. **GitHub 開源專案** (`https://github.com/sunpochin`) - 公開使用

---

## 3. 檔案結構 (File Structure)

```text
sunpochin.github.io/
├── index.html     # 主頁面 (HTML5 語意化 + 漸進增強骨架 + Vanilla JS)
├── styles.css     # 行動優先 Modern Glassmorphism 樣式表 (原生 CSS 變數)
├── favicon.svg    # 向量標誌圖示 (高畫質暗色光暈門牌 SVG)
├── services.json  # 結構化服務項目資料 (名稱、網址、按鈕文字、目標受眾)
└── TECHNICAL.md   # 本架構技術說明文件
```
