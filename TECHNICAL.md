# TECHNICAL.md - sunpochin.github.io 技術架構與設計決策

本文件記錄 `sunpochin.github.io` 門牌架構設計決策、多區塊分類規劃、PM2 本地預覽流程與排除的替代方案。

---

## 1. 三分頁專區與三入口架構設計 (Core, Life & Work Architecture)

為了確保核心數位照護工具 (Core)、吃喝玩樂社交舞連結 (Life) 與工程求職履歷 (Work) 目標明確且彼此干擾降至最低，網站採用三分頁膠囊導覽結構 (Portal Navigation Bar)：

```text
sunpochin.github.io/
├── index.html       # [Core 核心入口] 數位門牌首頁與家健錄 (JiaJian Log) 照護營運工具
├── styles.css       # 全站膠囊導覽列與門牌暗色玻璃質感 (Glassmorphism) CSS
├── favicon.svg      # 門牌徽章標誌
├── services.json    # 服務與連結數據 (分 core 與 leisure)
│
├── life/
│   ├── index.html   # [Life 生活專頁] 💃 雙人舞舞班、Podcast 翻譯、Spotify 歌單與歌詞部落格
│   └── styles.css   # 生活專區專屬 CSS
│
└── work/
    ├── index.html   # [Work 履歷專頁] 💻 資深前端/架構師履歷、全棧作品與技術棧展演
    └── styles.css   # 作品集專屬高階暗色主題 CSS
```

* **Core 核心首頁 (`/`)**：專注於核心家庭照護工具（家健錄 `jia-jian-log.vercel.app`），頂部提供 Work 履歷快速入口（Life 入口暫時隱藏）。
* **Work 履歷專頁 (`/work/`)**：精選全棧 CareOps 兩大旗艦作品：**家健錄 (JiaJian Log)** 與 **好溝通翻譯 Care Translate (LINE ID: @652ouobw)**，展現 React 18 / Supabase RLS / Vitest CI/CD 技術細節。內建 `<meta name="robots" content="noindex, nofollow">`。

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
| **將社交舞與生活連結混入家健錄同一個列表** | 會破壞核心照護工具（家健錄 JiaJian Log）的嚴肅感與明確性，使用者無法快速區分專業工具與個人休閒筆记。 |
| **首頁放置巨幅履歷按鈕** | 混淆一般服務使用者與面試官的存取意圖，讓血壓紀錄等工具的使用者感到非必要的干擾。 |
| **採用 `/portfolio/` 或 `/hire-me/` 路徑** | `/work/` 比 `/portfolio/` 更簡潔專業，且不若 `/hire-me/` 過於著急求職。 |
| **依賴複雜打包工具產出多頁面** | 兩頁面皆採用靜態語意 HTML5 + 原生 CSS，免除打包繁瑣步驟與依賴安全性問題。 |

---

## 4. 家健錄 (JiaJian Log) 求職技術細節展演設計 (JiaJian Log Tech Stack Exhibition)

為了讓面試官與獵頭能在 `/work/` 頁面中直接了解專案的全棧深度，於 `/work/index.html` 之作品卡片新增 `.tech-stack-details` 架構專區：
- **前端 Ecosystem**: React 18, TypeScript 5.6 (全型別覆蓋), Vite 6, Tailwind CSS v4, Bun 1.3
- **後端與資安**: Supabase (PostgreSQL), Row Level Security (RLS) DB 層級限制, Google OAuth 2.0 雙重白名單驗證
- **UX 創新**: iOS 原創 WheelPicker 雙向滾輪選擇器、台灣高血壓學會 722 原則雙次量測自動流轉與 1 分鐘休息計時器
- **印台雙語 i18n**: 印尼文（看護主用）+ 繁體中文（家屬主用）對稱切換
- **DevOps & CI/CD**: 92.9%+ Vitest 單元測試涵蓋率、GitHub Actions 自動觸發拋棄式 Local Supabase 執行 DB Reset 測試與隔離 Staging 驗收環境

