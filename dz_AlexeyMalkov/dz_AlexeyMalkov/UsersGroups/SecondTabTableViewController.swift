//
//  SecondTabTableViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class SecondTabTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var token: NotificationToken?
    
    let group = realm.objects(GroupListRealm.self)
    var sortedGroup = realm.objects(GroupListRealm.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        loadUserGroups()
        self.tableView.reloadData()
        
        self.token = sortedGroup.observe({ (changes: RealmCollectionChange) in
            switch changes{
            case .initial(let result):
                print(result)
            case.update(_, deletions: _, insertions: _, modifications: _):
                self.tableView.reloadData()
            case.error(let error):
                print(error.localizedDescription)
                       }
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            sortedGroup = group
            tableView.reloadData()
            return
        }
        sortedGroup = group.filter(" groupName BEGINSWITH '\(searchBar.text!)'")
        tableView.reloadData()
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

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "addGroup", let globalGroupsTebleViewController = segue.destination as? GlobalGroupsTebleViewController {
//            globalGroupsTebleViewController.delegate = self
//        }
//    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedGroup.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersGropus", for: indexPath) as! UsersGroupsTableViewCell
        let object = sortedGroup[indexPath.row]
        cell.setGroup(object: object)
        
        return cell
    }
}

//extension SecondTabTableViewController: GlobalGroupsTebleViewControllerDelegate {
//    func didSelectGroupList(list: GroupList) {
//        sortedGroup.append(list)
//        tableView.reloadData()
//    }
//}
