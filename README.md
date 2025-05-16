# KDAM-Demo

這是 KDAM 面試作業的 iOS 範例專案，主要功能包含：

- 用戶列表（User List）
  - 支援分頁載入
  - 支援刷新
  - 採用 **MVVM** 架構設計
- 用戶明細（User Detail）
  - 展示單一用戶詳細資訊
  - 採用 **MVC** 架構設計

專案中使用了以下第三方套件：
- [Alamofire](https://github.com/Alamofire/Alamofire) — 處理網路請求
- [Kingfisher](https://github.com/onevcat/Kingfisher) — 網路圖片快取與顯示

---

## 架構說明

### MVVM (用戶列表)

用戶列表採用 MVVM 架構，理由包括：

- 分離 UI 與商業邏輯，使 ViewModel 處理資料轉換與狀態管理，ViewController 僅負責 UI 呈現
- 易於擴展分頁及刷新功能，並方便進行單元測試
- 讓 Controller 保持輕量化，提升維護與可讀性

### MVC (用戶明細)

用戶明細頁面因邏輯較簡單，採用傳統 MVC 架構：

- 單一頁面，資料與互動較少，MVC 可快速實作且易懂
- 無需額外建立 ViewModel，提升開發效率

---

## 功能介紹

- **用戶列表**
  利用 GitHub API 抓取使用者資料，支援分頁載入與刷新。(圖中的皇冠表示是否為 site_admin)
  ![Simulator Screenshot](Simulator%20Screenshot.png)
- **用戶明細**
  點選用戶列表可查看該用戶的詳細資訊（頭像、名稱、所在地等）。
- **圖片快取**
  使用 Kingfisher 下載及快取使用者頭像，提升載入效率與用戶體驗。
- **網路請求**
  使用 Alamofire 進行 API 呼叫與 JSON 資料解析。
