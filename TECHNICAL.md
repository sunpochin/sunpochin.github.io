# TECHNICAL.md - sunpochin.github.io 技術架構與設計決策

本文件記錄 `sunpochin.github.io` 雙入口門牌架構設計決策、PM2 本地預覽流程與排除的替代方案。

---

## 1. 雙入口架構設計 (Dual Portal Architecture)

為避免將求職履歷/作品集直接混入一般終端使用者的首頁，將網站劃分為兩個獨立職責路徑：

```text
sunpochin.github.io/
├── index.html       # [一般使用者入口] 服務門牌 (無履歷求職干擾，極速門牌)
├── styles.css       # 門牌專屬行動優先 CSS
├── favicon.svg      # 門牌徽章標誌
├── services.json    # 服務數據資料點
│
└── work/
    ├── index.html   # [面試官/獵頭入口] 工程師履歷、作品與技術能力展示
    └── styles.css   # 作品集專屬高階暗色主題 CSS
```

* **一般使用者首頁 (`/`)**：單純展示線上運行之服務門牌（如 `bp-722.vercel.app`），按鈕明確標示服務內容，不放「我的履歷」等求職按鈕。
* **面試官專屬頁面 (`/work/`)**：展示前端工程作品、技術棧與架構理念。內建 `<meta name="robots" content="noindex, nofollow">` 避免搜尋引擎隨意索引。

---

## 2. PM2 本地開發與 PR 預覽流程 (PM2 Local Preview Workflow)

在 GitHub PR 尚未 Merge 前，GitHub Pages 官方 Workflow 不會自動將未合併的分支部署至正式網域。因此在 local / dev 環境採用 PM2 提供即時預覽：

### 啟動預覽服務
```bash
pm2 serve . 4173 --name sunpochin-preview
```

### 本地測試入口
* **一般使用者首頁預覽**：`http://localhost:4173/`
* **面試官作品頁面預覽**：`http://localhost:4173/work/`

### PR Merge 後正式網址
* **服務門牌**：`https://sunpochin.github.io/`
* **作品經歷**：`https://sunpochin.github.io/work/`

---

## 3. 排除的替代方案 (Rejected Alternatives)

| 替代方案 | 排除原因 (Why Rejected) |
| :--- | :--- |
| **首頁放置巨幅履歷按鈕** | 混淆一般服務使用者與面試官的存取意圖，讓血壓紀錄等工具的使用者感到非必要的干擾。 |
| **採用 `/portfolio/` 或 `/hire-me/` 路徑** | `/work/` 比 `/portfolio/` 更簡潔專業，且不若 `/hire-me/` 過於著急求職。 |
| **依賴複雜打包工具產出多頁面** | 兩頁面皆採用靜態語意 HTML5 + 原生 CSS，免除打包繁瑣步驟與依賴安全性問題。 |
