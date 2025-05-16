//
//  UserListViewModel.swift
//  KDAN Demo
//
//  Created by Felix Chin on 2025/5/15.
//

import Foundation

class UserListViewModel {
    
    // MARK: - Private Property
    
    private var users: [User] = []
    private var lastUserId = 0
    
    // MARK: - Get
    
    func getUsers(since: Int = 0, successHandle: (() -> ())?, failureHandle: ((Error) -> ())?) {
        Communicator.shared.getUserList { users, error in
            if let error = error {
                failureHandle?(error)
                return
            }
            
            guard let users = users else {
                let error = NSError(domain: "no data", code: 909)
                failureHandle?(error)
                return
            }
            
            self.users = users
            self.lastUserId = users.last?.id ?? 0
            successHandle?()
        }
    }
    
    func getNextUsers(successHandle: (() -> ())?, failureHandle: ((Error) -> ())?) {
        Communicator.shared.getUserList(since: lastUserId) { users, error in
            if let error = error {
                failureHandle?(error)
                return
            }
            
            guard let users = users else {
                let error = NSError(domain: "no data", code: 909)
                failureHandle?(error)
                return
            }
            
            self.users += users
            self.lastUserId = users.last?.id ?? 0
            successHandle?()
        }
    }
    
    func getUser(at index: Int) -> User {
        return users[index]
    }
    
    func getUsersCount() -> Int {
        return users.count
    }
    
}
