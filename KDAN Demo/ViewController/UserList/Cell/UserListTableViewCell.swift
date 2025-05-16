//
//  UserListTableViewCell.swift
//  KDAN Demo
//
//  Created by Felix Chin on 2025/5/15.
//

import UIKit
import Kingfisher

class UserListTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    
    @IBOutlet private weak var headImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var siteAdminImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headImageView.layer.cornerRadius = 20
        headImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        headImageView.image = nil
        userNameLabel.text = "user name"
        siteAdminImageView.isHidden = true
    }
    
}

// MARK: - Configure

extension UserListTableViewCell {
    
    func configureCell(user: User) {
        userNameLabel.text = user.login
        siteAdminImageView.isHidden = !user.siteAdmin
        Communicator.shared.urlloadHeadImage(url: user.avatarURL.absoluteString, img: headImageView)
    }
    
}
