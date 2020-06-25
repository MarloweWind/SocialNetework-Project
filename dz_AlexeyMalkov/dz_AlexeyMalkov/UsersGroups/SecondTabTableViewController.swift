//
//  SecondTabTableViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

class SecondTabTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let networkService = NetworkService()
    
    var sortedGroup = [GroupList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        networkService.loadUserGroups(userId: UserSession.shared.userId) { group in
            self.sortedGroup = self.sort(groups: group)
            self.tableView?.reloadData()
        }
    }
    
    private func sort(groups: [GroupList], prefix: String = "") ->[GroupList] {
        var result = [GroupList]()
        
        groups.forEach { group in
            if !prefix.isEmpty && !group.groupName.lowercased().contains(prefix.lowercased()) {
                return
            }
            result.append(group)
        }
        return result
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.sortedGroup = self.sort(groups: sortedGroup, prefix: searchText)
        tableView.reloadData()
        if searchText == "" {
            viewDidLoad()
        } else {
            self.sortedGroup = self.sort(groups: sortedGroup, prefix: searchText)
            tableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.reloadData()
        viewDidLoad()
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            group.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGroup", let globalGroupsTebleViewController = segue.destination as? GlobalGroupsTebleViewController {
            globalGroupsTebleViewController.delegate = self
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedGroup.count
    }
var cachedAvatars = [String: UIImage]()
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersGropus", for: indexPath) as! UsersGroupsTableViewCell
        let groupName = sortedGroup[indexPath.row].groupName
        cell.groupName?.text = groupName
        let group = sortedGroup[indexPath.row]
        let url = URL(string: group.groupAvatar)
        cell.groupAvatar.kf.setImage(with: url)
        
        return cell
    }
}

extension SecondTabTableViewController: GlobalGroupsTebleViewControllerDelegate {
    func didSelectGroupList(list: GroupList) {
        sortedGroup.append(list)
        tableView.reloadData()
    }
}
