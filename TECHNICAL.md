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

## 5. 雙人舞知識分享子頁面架構與教學設計 (Life Knowledge Sharing Subportal Architecture)

為滿足社交舞池音樂性與傳統步法（Dominican Footwork）知識傳播需求，於 `/life/` 下建立靜態長文知識專區 `/life/knowledge/`：

### 5.1 目錄結構與定位
```text
life/
├── index.html          # [Life 入口] 雙人舞與生活筆記 (頂部加入知識分享膠囊導覽與旗艦卡片推薦)
├── styles.css          # 生活專區微調樣式
├── blood-pressure.html # 722 雙次量測 1 分鐘休息計時輔助工具
└── knowledge/
    ├── index.html      # [知識分享主頁 & 首篇教學] Bachata 步法與 Mambo 段音樂結構解析
    └── styles.css      # 長文專用排版樣式表 (支援拍點視覺化、樂段對照表、文獻卡片與 16:9 影音容器)
```

### 5.2 技術決策與舞者取向實戰影音整合 (Dancer-Oriented Practical Video Architecture)
為了避免傳統樂理過度生硬抽象，文章全面重構為**「舞者取向 (Dancer-Centric)」**結構，精確標記實戰影片秒數、聽覺訊號與步法動作：
1. **五大實戰影音時間戳與動作拆解**：
   - **Michael de Miranda (`ugXrFsLbkgQ`)**：純打擊樂段落切換。標記 `06:30 - 09:30` Bongó 加速如小馬奔馳（Horse-running rhythm）之 Mambo 爆發點。
   - **Juan Ruiz (`RKScNYg8Cy8`)**：32 拍大句子結構。標記 `00:45 - 01:30` 第 4 個 8 拍（5-6-7-8）之 Build-Up / The Call 換段預判。
   - **Cuellar Bachatero (`kfjZyMT_kMQ`)**：實戰曲目段落。標記 `00:45` 判斷進入 Mambo 分開、`04:00` 踩出前後推步、切分交叉步與腳跟點地。
   - **Marius & Elena (`KYkknLddKKY`)**：初學者 Mambo 步法。標記 `01:15` 前後 Mambo Step 與 `1, 3, 5, 7` 停頓（Stops）及雙人分合引導。
   - **Ermes Dance (`1bE_j35oeGo`)**：下盤穩定。提煉膝蓋微彎沉地、小步踩踏、核心放鬆等 3 大步法心法。
2. **雙欄結構化卡片與視覺化拍點**：
   - 採用 `.dancer-case-card` 與 `.action-duo-grid` 建立「👂 聽覺關鍵秒數」與「🦶 舞者當下動作」雙欄對照。
   - 提供快速速查表（Cheat Sheet）與直接帶秒數參數（`?start=...`）的 YouTube 嵌入播放器。

### 5.3 排除的替代方案 (Rejected Alternatives)

| 替代方案 | 排除原因 (Why Rejected) |
| :--- | :--- |
| **僅提供純樂器樂理教學影片** | 對一般社交舞者過於抽象難懂。舞者需要知道的是「聽到這聲音我該跳什麼步、什麼時候放開手」。 |
| **將長篇教學直接堆疊在 `/life/index.html`** | 會嚴重破壞生活首頁作為「精選連結導覽門牌」的輕巧性與掃讀體驗。拆分至 `/life/knowledge/` 子目錄能保持職責分離。 |
| **僅以外部連結導向 Medium 或 Hashnode** | 使用者明確希望在 GitHub Pages 個人網域 (`/life/`) 內建立知識體系，保留個人網站網域權威與設計一致性。 |
| **引入靜態網站產生器 (SSG / Astro / Hugo)** | 現有站點採用純原生 HTML5 + CSS，免除打包依賴。為單篇教學引入 SSG 打包工具會增加維護負擔與 CI/CD 複雜度。 |


