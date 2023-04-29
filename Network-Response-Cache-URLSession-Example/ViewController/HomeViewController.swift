//
//  HomeViewController.swift
//  Network-Response-Cache-URLSession-Example
//
//  Created by Sparkout on 20/04/23.
//

import UIKit

class HomeViewController: UITableViewController {
    let getUserDetails: UsersViewModel = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        let url: URL = .init(string: "https://6446ae39ee791e1e29063b0f.mockapi.io/url-session/users")!
//        let request: URLRequest = .init(url: url)
//        let response = URLCache.shared.cachedResponse(for: request)
//        let responseData = response!.data
//        print("Cached: ", String(data: responseData, encoding: .utf8))
    }
    
    private func setupView() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
        getUserDetails(cache: true)
        getUserDetails.userListCompletion = { _ in
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        getUserDetails(cache: false)
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getUserDetails.users?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = getUserDetails.users?[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = item?.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Users"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action1: AlertBoxAction = .init(title: "Cancel", fill: false) {
            self.presentedViewController?.dismiss(animated: true)
        }
        let action2: AlertBoxAction = .init(title: "OK") { print(#function, #line) }
        let action3: AlertBoxAction = .init(title: "Logout") { print(#function, #line) }
        let title = "Apple User"
        let decription = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries"
        let vc = AlertBoxController(
            title: title,
            description: decription,
            actions: action3, action2, action1
        )
        AlertBoxController.themeColor = .orange
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
}
