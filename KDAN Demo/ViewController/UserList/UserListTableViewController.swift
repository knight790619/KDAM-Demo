//
//  UserListTableViewController.swift
//  KDAN Demo
//
//  Created by Felix Chin on 2025/5/15.
//

import UIKit

class UserListTableViewController: UITableViewController {
    
    // MARK: - Private Property
    
    private let viewModel = UserListViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsers()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getUsersCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userListTableViewCell", for: indexPath) as! UserListTableViewCell
        
        let user = viewModel.getUser(at: indexPath.row)
        cell.configureCell(user: user)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let userCount = viewModel.getUsersCount()
        /// 因為未使用 Github API Token 進行呼叫，會有每小時呼叫次數限制，故在此做限制
        if userCount == 200 {
            tableView.tableFooterView = makeNoMoreDataFooter()
            return
        } else {
            tableView.tableFooterView = nil
        }
        
        // 分頁
        let lastRow = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRow {
            getNextPage()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.getUser(at: indexPath.row)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "UserDetailTableViewController") as! UserDetailTableViewController
        viewController.configure(with: user.login)
        
        show(viewController, sender: nil)
    }
    
}

// MARK: - Configrure Layout

private extension UserListTableViewController {
    
    func makeNoMoreDataFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let label = UILabel(frame: footerView.bounds)
        label.text = "沒有更多資料了"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        footerView.addSubview(label)
        return footerView
    }
}

// MARK: - @IBAction

private extension UserListTableViewController {
    
    @IBAction func didClickRefreshButton(_ sender: Any) {
        getUsers()
    }
    
}

// MARK: - API

private extension UserListTableViewController {
    
    func getUsers() {
        LoadingView.shared.showLoadingView()
        
        viewModel.getUsers(successHandle: { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                LoadingView.shared.hideLoadingView()
                
                guard let strongSelf = self else { return }
                strongSelf.tableView.reloadData()
            }
            
        }, failureHandle: { [weak self] error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                LoadingView.shared.hideLoadingView()
                
                guard let strongSelf = self else { return }
                Common.showAlert(on: strongSelf, style: .alert, title: "錯誤", message: error.localizedDescription)
            }
        })
    }
    
    func getNextPage() {
        viewModel.getNextUsers(successHandle: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }, failureHandle: { [weak self] error in
            guard let strongSelf = self else { return }
            Common.showAlert(on: strongSelf, style: .alert, title: "錯誤", message: error.localizedDescription)
        })
    }
    
}
