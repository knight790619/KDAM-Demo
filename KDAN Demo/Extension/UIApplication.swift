//
//  UIApplication.swift
//  KDAN Demo
//
//  Created by Felix Chin on 2025/5/15.
//

import UIKit

extension UIApplication {
    
    var currentKeyWindow: UIWindow? {
        return self.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first { $0.isKeyWindow }
    }
    
}
