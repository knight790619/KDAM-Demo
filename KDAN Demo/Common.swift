//
//  Common.swift
//  KDAN Demo
//
//  Created by Felix Chin on 2025/5/15.
//

import UIKit

class Common {
    
    /// Alert 僅有確定按鈕
    static func showAlert(on: UIViewController, style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "確定", style: .default, handler: nil)], completion: (() -> Swift.Void)? = nil) {
        
        // 檢查是否已經有 UIAlertController 正在顯示中
        if on.presentedViewController is UIAlertController {
            print("已有 Alert 正在顯示，略過顯示新的 Alert。")
            return
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        on.present(alert, animated: true, completion: completion)
    }
    
    static func formatCreatedAt(_ isoDateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        guard let date = isoFormatter.date(from: isoDateString) else {
            return "日期格式錯誤"
        }
        
        let displayFormatter = DateFormatter()
        displayFormatter.locale = Locale(identifier: "zh_TW")
        displayFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        return displayFormatter.string(from: date)
    }
}
