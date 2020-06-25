//
//  GlobalGroupsTebleViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

protocol GlobalGroupsTebleViewControllerDelegate: AnyObject {
    func didSelectGroupList(list: GroupList)
}

class GlobalGroupsTebleViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var networkService = NetworkService()
    
    var group = [GroupList]()
    var sortedGroup = [GroupList]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sortedGroup = sort(groups: group)
        searchBar.delegate = self
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        networkService.loadAllGroups(q: searchBar.text!, completion: { group in
            self.sortedGroup = self.sort(groups: group, prefix: searchText)
            self.tableView.reloadData()
        })
    }
    
    weak var delegate: GlobalGroupsTebleViewControllerDelegate?

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sortedGroup.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "globalGroups", for: indexPath) as! GlobalGroupsTableViewCell
        let groupName = sortedGroup[indexPath.row].groupName
        cell.globalGroupName?.text = groupName
        let group = sortedGroup[indexPath.row]
        let url = URL(string: group.groupAvatar)
        cell.globalGroupAvatar.kf.setImage(with: url)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectGroupList(list: group[indexPath.row])
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
