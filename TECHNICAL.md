# TECHNICAL.md - sunpochin.github.io 技術架構與設計決策

本文件記錄 `sunpochin.github.io` 個人工程作品集架構設計決策、Hallmark 反 AI 樣板重構、PM2 本地預覽流程與排除的替代方案。

---

## 1. 孫柏青前端工程作品集架構設計 (Personal Engineering Portfolio Architecture)

依據 Hallmark 設計原則與個人定位，首頁由傳統「SaaS 服務目錄 / 數位門牌」升級重構成**以孫柏青為核心、家健錄為旗艦案例的前端工程作品集**：

```text
sunpochin.github.io/
├── index.html       # [作品集首頁] 以孫柏青為核心的前端工程作品集 (包含家健錄旗艦案例與音樂/DJ 介紹)
├── styles.css       # Hallmark 典雅出版物感 (Editorial Warm) 樣式表 (摒棄發光漸層與 Glassmorphism AI 樣板)
├── favicon.svg      # 門牌徽章標誌
├── assets/
│   └── images/
│       ├── sunpochin-outdoor.jpg  # 孫柏青野外照片 (配置於 Hero / 工程師簡介區塊)
│       └── sunpochin-dj.jpg       # 孫柏青 DJ 照片 (配置於 Life / 音樂與社交雙人舞區塊)
├── services.json    # 服務與連結數據
│
└── work/
    ├── index.html   # [Work 履歷專頁] 💻 資深前端/架構師履歷、全棧作品與技術棧展演
    └── styles.css   # 作品集專屬高階暗色主題 CSS
```

* **作品集首頁 (`/`)**：
  - **Hero 工程師定位**：展示孫柏青前端工程特質，搭配高山草原野外照片（`sunpochin-outdoor.jpg`），建立真實自信的第一印象。
  - **旗艦案例（家健錄 JiaJian Log）**：深入展示「媽媽今天吃的是新藥單，還是上週的舊藥單？」真實需求、中印雙語 UI、Supabase RLS 資料庫層存取防護與 92.9% Vitest 測試。
  - **精選專案 (Care Translate & Cloudflare Workers)**：收納印尼語照護翻譯 LINE Bot 與無伺服器通知整合。
  - **人生的地方（Salsa DJ & Social Dancing）**：搭配 DJ 耳機照（`sunpochin-dj.jpg`），展示對介面流暢度與使用者感情脈動的敏銳觀察。
* **Work 履歷專頁 (`/work/`)**：提供求職面試官與獵頭極詳細的全棧技術棧、系統架構設計決策與工作履歷展演。

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
| **使用典型暗色 Glassmorphism 與藍紫發光漸層** | 容易形成同質化的「AI SaaS Template / API Response 穿西裝」廉價感。改採 Hallmark Editorial Warm 典雅溫暖風格，更具個性與專業度。 |
| **首頁僅作為純服務選單 (Service Catalog)** | 無法在 5 秒內讓面試官理解「孫柏青是誰、能力為何」，缺乏前端工程師個人辨識度。 |
| **完全刪除社交雙人舞與音樂筆記** | 個人跨領域愛好（Salsa DJ）是強大的記憶點與人文辨識度，能使工程形象更加立體生動。 |
| **採用 `/portfolio/` 或 `/hire-me/` 路徑** | `/work/` 比 `/portfolio/` 更簡潔專業，且不若 `/hire-me/` 過於著急求職。 |

---

## 4. 家健錄 (JiaJian Log) 求職技術細節展演設計 (JiaJian Log Tech Stack Exhibition)

為了讓面試官與獵頭能在 `/work/` 頁面中直接了解專案的全棧深度，於 `/work/index.html` 之作品卡片新增 `.tech-stack-details` 架構專區：
- **前端 Ecosystem**: React 18, TypeScript 5.6 (全型別覆蓋), Vite 6, Tailwind CSS v4, Bun 1.3
- **後端與資安**: Supabase (PostgreSQL), Row Level Security (RLS) DB 層級限制, Google OAuth 2.0 雙重白名單驗證
- **UX 創新**: iOS 原創 WheelPicker 雙向滾輪選擇器、台灣高血壓學會 722 原則雙次量測自動流轉與 1 分鐘休息計時器
- **印台雙語 i18n**: 印尼文（看護主用）+ 繁體中文（家屬主用）對稱切換
- **DevOps & CI/CD**: 92.9%+ Vitest 單元測試涵蓋率、GitHub Actions 自動觸發拋棄式 Local Supabase 執行 DB Reset 測試與隔離 Staging 驗收環境

---

## 5. 雙人舞與拉丁音樂知識專區架構 (Life Knowledge Sharing Subportal Architecture)

為滿足社交舞池音樂性、傳統步法（Footwork）與經典拉丁舞曲深度賞析之需求，於 `/life/knowledge/` 建立高擴充性之靜態文章專區：

### 5.1 目錄結構與多文章體系 (Multi-Article Architecture)
```text
life/
├── index.html          # [Life 入口] 雙人舞與生活筆記 (提供知識專區總覽入口推薦卡片)
├── styles.css          # 生活專區微調樣式
├── blood-pressure.html # 722 雙次量測 1 分鐘休息計時輔助工具
└── knowledge/
    ├── index.html      # [知識專區總覽 Hub] 精選文章卡片網格 (提供標籤、閱讀時間、摘要與導覽)
    ├── styles.css      # 專區共用模組化樣式表 (重構精簡，支援卡片網格、雙欄聽覺/動作對照、對照表與影音容器)
    ├── bachata-mambo.html                 # [專文 1] Bachata Mambo 段聽覺判斷與 Footwork 步法拆解
    └── cuban-sound-project-taka-taka.html # [專文 2] Demetrio Muñiz《Taka Taka》與 1972 年原版跨世代深度對比
```

### 5.2 樣式表重構與精簡策略 (Stylesheet Refactoring)
針對原先僅針對單篇教學特化的 `life/knowledge/styles.css` 進行模組化重構：
1. **雙核心模式支援**：明確切分「專區總覽卡片網格 (`.articles-grid`, `.article-card`)」與「深度長文閱讀排版 (`.article-container`, `.article-body`)」。
2. **消弭冗餘宣告**：重疊的選擇器整合至共享 Glassmorphism 與 Shadow Token，移除未使用的特定樣式，同時保持對手機直向、平板與桌面寬螢幕的流暢響應。
3. **組件複用性強化**：`.video-wrapper`、`.action-duo-grid`、`.music-structure-table` 與 `.sources-card` 成為跨文章通用組件。

### 5.3 專文二內容與音樂性設計 (Cuban Sound Project 《Taka Taka》)
1. **跨世代雙版本對比**：
   - **原版 (1972)**：Joe Dassin《Taka takata (La femme du toréro)》（改編自 Paco Paco 與 Al Verlane），聚焦於幽默法語香頌、西班牙鬥牛步 (Paso Doble) 與佛朗明哥響板。
   - **古巴大樂團改編版 (2015)**：Buena Vista Social Club 音樂總監 Demetrio Muñiz & Cuban Sound Project，將歐洲流行歌改造成純血古巴 Big Band Salsa / Son Montuno。
2. **舞者與 DJ 視角解析**：
   - 拆解長號組重擊（Trombone Breaks）、鋼琴 Montuno 滾動與天巴鼓牛鈴（Campana）推進機制。
   - 分析古巴傳統呼應結構（Coro-Pregón）如何將「Taka-taka」轉化為舞池全場的狂歡號角。
   - 附上雙 YouTube 播放器嵌入與雙人舞實戰應對技巧（前奏、主歌、Solo Shines）。

### 5.4 排除的替代方案 (Rejected Alternatives)

| 替代方案 | 排除原因 (Why Rejected) |
| :--- | :--- |
| **將所有文章直接串接在單一 `index.html` 內** | 隨著文章增多，單一長頁面會造成捲動負擔過大、SEO 與社群分享預覽卡片 (Open Graph) 標題混淆，亦違背使用者明確要求的不同頁面架構。 |
| **使用 SPA / 前端路由 (React / Vue Hash Routing)** | 增加不必要的打包與客戶端渲染負擔。靜態多頁（Multi-Page Application）具備最佳的秒開速度、直接連結分享性與 GitHub Pages 最佳相容性。 |
| **僅提供純樂器樂理教學** | 對社交舞者過於抽象難懂。舞者需要知道「聽到這個聲音該跳什麼步、什麼時候放開手、以及歌曲背後的脈絡」。 |
| **引入龐大前端 CSS 框架 (Tailwind / Bootstrap)** | 會破壞既有全站高質感 Slate Dark Glassmorphism 設計系統，並增加建置工具鏈的複雜度。純原生 CSS 變數與重構後的模組化樣式維護性更高。 |



