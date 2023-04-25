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
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
        getUserDetails(cache: true)
        getUserDetails.userListCompletion = { error in
            if error == nil { self.tableView.reloadData() }
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
        let vc = AlertBoxController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
