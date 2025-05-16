//
//  UserDetailTableViewController.swift
//  KDAN Demo
//
//  Created by Felix Chin on 2025/5/16.
//

import UIKit

class UserDetailTableViewController: UITableViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet private weak var headImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var companyLabel: UILabel!
    @IBOutlet private weak var blogLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var publicReposLabel: UILabel!
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var followingLabel: UILabel!
    @IBOutlet private weak var createdAtLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

// MARK: - Configure

extension UserDetailTableViewController {
    
    func configure(with userName: String) {
        getUserDetail(userName: userName)
    }
    
}

// MARK: - Configure Layout

private extension UserDetailTableViewController {
    
    func configureLayout(userDetail: UserDetail) {
        headImageView.layer.cornerRadius = 30
        headImageView.clipsToBounds = true
        
        Communicator.shared.urlloadHeadImage(url: userDetail.avatarURL.absoluteString, img: headImageView)
        nameLabel.text = userDetail.login
        
        companyLabel.text = userDetail.company ?? "Unknown"
        blogLabel.text = userDetail.blog ?? "Unknown"
        locationLabel.text = userDetail.location ?? "Unknown"
        emailLabel.text = userDetail.email ?? "Unknown"
        bioLabel.text = userDetail.bio ?? "Unknown"
        publicReposLabel.text = "\(userDetail.publicRepos)"
        followersLabel.text = "\(userDetail.followers)"
        followingLabel.text = "\(userDetail.following)"
        createdAtLabel.text = Common.formatCreatedAt(userDetail.createdAt)
    }
    
}

// MARK: - API

private extension UserDetailTableViewController {
    
    func getUserDetail(userName: String) {
        Communicator.shared.getUserDetail(userName: userName) { [weak self] userDetail, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                Common.showAlert(on: strongSelf, style: .alert, title: "錯誤", message: error.localizedDescription, completion: {
                    self?.navigationController?.popViewController(animated: true)
                    return
                })
            }
            
            guard let userDetail = userDetail else {
                let error = NSError(domain: "no data", code: 909)
                Common.showAlert(on: strongSelf, style: .alert, title: "錯誤", message: error.localizedDescription, completion: {
                    self?.navigationController?.popViewController(animated: true)
                })
                return
            }
            
            strongSelf.configureLayout(userDetail: userDetail)
        }
    }
    
}
