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
        getUserDetails()
        getUserDetails.userListCompletion = { error in
            if error == nil { self.tableView.reloadData() }
        }
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
}
