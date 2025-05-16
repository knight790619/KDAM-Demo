//
//  LoadingView.swift
//  KDAN Demo
//
//  Created by Felix Chin on 2025/5/15.
//

import UIKit

class LoadingView {
    static let shared = LoadingView()
    
    // MARK: - Private Properties
    
    private var containerView = UIView()
    private var progressView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    private var isLoading = false
    
    /// 顯示LoadingView
    func showLoadingView() {
        isLoading = true
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        containerView.frame = window.frame
        containerView.center = window.center
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = window.center
        progressView.backgroundColor = UIColor(resource: ._000000_70)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        UIApplication.shared.currentKeyWindow?.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    /// 隱藏LoadingView
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.isLoading = false
            self.activityIndicator.stopAnimating()
            self.containerView.removeFromSuperview()
        }
    }
    
}
