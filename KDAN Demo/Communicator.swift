//
//  Communicator.swift
//  KDAN Demo
//
//  Created by Felix Chin on 2025/5/14.
//

import Foundation
import Alamofire
import Kingfisher

class Communicator {
    
    // MARK: - Public Property
    
    static let shared = Communicator()
    
    // MARK: - Private Preperties
    
    private static let BASEURL = "https://api.github.com/"
    private static let sharedCache: ImageCache = {
        let cache = ImageCache(name: "headView")
        cache.diskStorage.config.sizeLimit = 300 * 1024 * 1024 // 300MB 磁碟快取上限
        cache.memoryStorage.config.totalCostLimit = 300 * 1024 * 1024 // 300MB 記憶體快取
        cache.memoryStorage.config.countLimit = 100 // 最多快取 100 張
        cache.diskStorage.config.expiration = .days(10) // 快取保存 10 天
        return cache
    }()
    
    // MARK: - Enum
    
    enum APIMethod: String {
        case users
        case userDetail
    }
    
    // MARK: - 用戶列表
    /// 用戶列表 (一次回傳 20筆)
    func getUserList(since: Int = 0, completion: @escaping ([User]?, Error?) -> Void) {
        let url = Communicator.BASEURL + APIMethod.users.rawValue
        // since 是使用最後一筆 userID
        let parameters = ["since": since, "per_page": 20]
        
        AF.request(url, method: .get, parameters: parameters).validate().responseDecodable(of: [User].self) { response in
            switch response.result {
            case .success(let users):
                completion(users, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    // MARK: - 用戶詳細資料
    
    func getUserDetail(userName: String, completion: @escaping (UserDetail?, Error?) -> Void) {
        let url = Communicator.BASEURL + APIMethod.users.rawValue + "/\(userName)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: UserDetail.self) { response in
            switch response.result {
            case .success(let userDetail):
                completion(userDetail, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    /// 載入大頭貼圖片，使用 Kingfisher 快取與縮圖處理
    @MainActor func urlloadHeadImage(url: String, img: UIImageView) {
        guard let url = URL(string: url) else {
            img.image = UIImage(named: "picSignupProfileNull")
            return
        }
        
        // 顯示 loading indicator
        img.kf.indicatorType = .activity
        
        // 設定圖片縮圖處理器
        let processor = DownsamplingImageProcessor(size: CGSize(width: 100, height: 100))
        
        // 設定圖片
        img.kf.setImage(
            with: url,
            placeholder: UIImage(named: "default_headImage"),
            options: [
                .transition(.fade(0.3)),
                .processor(processor),
                .targetCache(Communicator.sharedCache),
                .backgroundDecode
            ]) { result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    img.image = UIImage(named: "default_headImage")
                }
            }
    }
    
}
