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
    
    var group: [GroupList] = [
    GroupList(groupName: "RST", groupAvatar: UIImage(named: "31")!),
    GroupList(groupName: "Zel RU", groupAvatar: UIImage(named: "32")!),
    ]
    
    var filtered = [GroupList]()
    var searching = false
    //серчбар
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = group.filter({$0.groupName.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            group.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGroup", let globalGroupsTebleViewController = segue.destination as? GlobalGroupsTebleViewController {
            globalGroupsTebleViewController.delegate = self
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filtered.count
        } else {
            return group.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersGropus", for: indexPath) as! UsersGroupsTableViewCell
        if searching {
            cell.groupAvatar.image = filtered[indexPath.row].groupAvatar
            cell.groupName.text = filtered[indexPath.row].groupName
        } else {
        
            cell.groupAvatar.image = group[indexPath.row].groupAvatar
            cell.groupName.text = group[indexPath.row].groupName
        }
        return cell
    }
}

extension SecondTabTableViewController: GlobalGroupsTebleViewControllerDelegate {
    func didSelectGroupList(list: GroupList) {
        group.append(list)
        tableView.reloadData()
    }
}
