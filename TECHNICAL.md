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

### 5.2 樣式表重構與色彩系統校準 (Stylesheet & Palette Calibration)
針對原先僅針對單篇教學特化且色彩過度雜亂的 `life/knowledge/styles.css` 進行系統性重構：
1. **雙核心模式支援**：明確切分「專區總覽卡片網格 (`.articles-grid`, `.article-card`)」與「深度長文閱讀排版 (`.article-container`, `.article-body`)」。
2. **全面接軌全站 Slate Dark Editorial 色彩體系**：
   - 淘汰高飽和度霓虹粉紫（`#ec4899`, `#a855f7`）與刺眼亮橘色塊，杜絕廉價 AI 範本感。
   - 回歸石墨暗底（`#090d16` / `#111726`）、極致微透光細線（`rgba(255, 255, 255, 0.08)`）與純淨白標題（`#f8fafc`）。
   - 以克制的天藍（`#38bdf8`，主視覺與聽覺）、薄荷綠（`#34d399`，身體動作）與溫潤琥珀（`#fbbf24`，古巴與歷史文化）建立專業、冷靜且高耐讀性的編輯部雜誌風格。
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

---

## 6. 好溝通翻譯 (Care Translate) 官方定價與金流審核專頁架構設計 (Merchant Review Landing Architecture)

為解決申請藍新金流（NewebPay）特店時「需要公開商品頁面但尚未能串接信用卡金流」的假循環問題，並嚴格遵循 `docs/product/payg-pricing-mvp.md` 的既定產品決策，於 `care-translate/` 建立專屬獨立靜態說明頁：

### 6.1 解決的核心認知盲點 (Breaking the False Circular Dependency)
* **常見誤解**：以為必須先在 `bahasa-tw-bot` 實作完成 Issue #35（藍新金流刷卡串接與 callback 驗證），才能向藍新申請商店。
* **真實審查常態**：
  - 藍新審核人員檢核的是「特店服務是否存在、賣什麼商品、價格多少、是否有服務條款、退款政策以及聯絡客服資訊」。
  - 刷卡能力（HashKey / HashIV / 特店代號）是金流公司「審核通過後」才核發給商家的憑證。在尚未過審前，特店本來就無法提供真刷卡功能。
  - 因此特店審核必備的是**公開、可存取、資訊齊全的商品與服務說明頁面**。

### 6.2 頁面構成要素與法令合規性 (Compliance & Page Elements)
1. **商品與服務說明 (`#features`)**：
   - 明確標示「好溝通翻譯 Care Translate」為 LINE 官方帳號（`@652ouobw`），提供台印雙向即時文字翻譯、長輩語音轉譯與藥單圖片辨識。
2. **公開透明 PAYG 預付定價 (`#pricing`)**：
   - 完全採用 `payg-pricing-mvp.md` 規格：
     - Free：NT$0 / 每月 30 units（不可累積）
     - 小包：NT$10 / 100 units
     - 標準包：NT$30 / 500 units
     - 大包：NT$50 / 1,000 units
   - 清楚列出 units 扣量加權標準（文字 1~3 units、語音 5 units/30s、圖片辨識 5 units、本地常用短句與系統指令 0 units 免費）。
3. **購買與開通流程 (`#workflow`)**：
   - 加入 LINE 好友 → 聊天室輸入 `/加值` → 導向藍新安全收銀台 → 完成付款 → LINE 推播即刻入帳。
4. **服務條款 (`#terms`)**：
   - 載明非醫療診斷之重要免責聲明（照護長輩急症仍須就醫）。
5. **退款政策 (`#refund`)**：
   - 依消保法第 19 條第 2 項及《通訊交易解除權合理例外情事適用準則》第 2 條第 5 款，明定本服務屬「經消費者事先同意始提供之非以有形媒介提供之數位內容」，購買開通後排除 7 日鑑賞期解除權。
   - 保留重大伺服器故障連續 7 日無法使用之例外退款申訴管道。
6. **特店資訊與客服管道 (`#contact`)**：
   - 載明負責人孫柏青、客服信箱 `sunpochin@gmail.com`、官方 LINE `@652ouobw` 及服務時間。
   - 明確標示金流交易委由藍新金流處理，採 TLS 256-bit 加密，本站不儲存信用卡機敏資料。

### 6.4 UI/UX Pro Max 視覺審查與照護信任淡色設計系統重構 (UI/UX Pro Max Redesign)

針對初版頁面產生的「視覺層次扁平、大片純白刺眼、文字密度過高而像政府申請文件/README」之問題，依據 `ui-ux-pro-max` 技能進行設計系統稽核與視覺層次重塑：

1. **色彩層次交替 (Rhythmic Surface Alternation)**：
   - **柔和灰底 (`#F5F7F8`)**：作為全頁基底，消除刺眼反光感，提升長時間閱讀舒適度。
   - **純淨白卡片 (`#FFFFFF`)**：搭載微浮凸陰影（`0 4px 20px -2px rgba(23, 37, 43, 0.05)`），使特色功能與流程清晰分明。
   - **淡藍綠交替區塊 (`#EEF7F5`)**：收費定價區專屬交替底色，打破縱向閱讀單調感。
   - **照護深湖水綠 (`#167C80`)**：專業、溫暖且沈穩的品牌主色，WCAG AA 對比度達標（>4.5:1）。
   - **LINE 官方綠 (`#06C755`)**：CTA 按鈕採用原生 LINE 綠，顯著強化加好友轉化動能。
2. **寬度與垂直節奏擴展 (1160px Container & Generous Vertical Rhythm)**：
   - 解決舊版繼承全站 920px 寬度導致 4 欄方案卡片壓迫窒息的缺陷，擴增至 `1160px`，並給予區塊 `5rem` 充裕呼吸空間。
3. **收費方案優雅突顯 (Scannable Pricing)**：
   - 500 units（標準包）作為主力推薦，採用深湖水綠外框、微幅縮放（`scale(1.02)`）與「最受歡迎 · 照護家庭首選」膠囊標籤，杜絕廉價霓虹發光或過度漸層。
4. **法規條款無障礙手風琴收納 (Accessible Legal Accordions)**：
   - 使用原生 `<details>` / `<summary>` 手風琴元件收納「服務條款」與「退款政策」。
   - **雙重優勢**：一般家庭造訪者不再被 200 行法律文字淹沒；藍新金流審核員亦可一鍵展開完整法規，且點擊頂部導覽列 `#terms` / `#refund` 錨點時透過 JavaScript 自動展開對應手風琴。

### 6.5 排除的替代方案 (Rejected Alternatives)

| 替代方案 | 排除原因 (Why Rejected) |
| :--- | :--- |
| **等 Worker 端 Issue #35 實作完成後再送件審核** | 陷入「沒商店代號無法測試真實扣款、沒頁面無法申請商店」的無效等待。商品頁先行即可立即解鎖金流特店審查流程。 |
| **在 Cloudflare Worker 中新增動態 HTML 路由** | Worker 的職責是 API 與 Webhook 處理，增加靜態 HTML 排版與條款渲染會造成程式碼雜亂且消耗 Worker 請求次數。放於 GitHub Pages 零維護成本且永久免費。 |
| **另外開獨立專案以 Cloudflare Pages 部署** | 增加額外 Git 倉儲與維護負擔。作者作品門牌 `sunpochin.github.io` 已具備高可信度之個人工程品牌背書，放於子目錄 `/care-translate/` 對藍新審核員更具真實性與信任度。 |
| **將頁面改為深色石墨主題 (Slate Dark)** | 照護服務面對的是台灣高齡長輩家屬，深色暗黑風格偏向開發者/終端機質感，缺乏居家照護的溫暖與醫療信任感。 |
| **直接刪除或大幅簡化服務條款與退款條文** | 藍新金流特店審核嚴格要求消費者權益保護與消保法第 19 條法定告知。條文過度簡化將導致特店審核退件。改採手風琴折疊在合規與 UX 間取得最佳平衡。 |
| **使用 AI SaaS 常見的高彩度霓虹漸層與大型玻璃擬態 (Glassmorphism)** | 造成浮誇不實的「AI 套版 Startup」廉價感，減損照護家庭對醫療溝通與金流交易的真實信賴度。 |




