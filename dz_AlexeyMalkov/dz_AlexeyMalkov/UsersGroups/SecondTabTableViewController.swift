//
//  SecondTabTableViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import RealmSwift

class SecondTabTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var token: NotificationToken?
    let group = realm.objects(GroupListRealm.self)
    var sortedGroup = realm.objects(GroupListRealm.self)
    var photoService: PhotoService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        loadUserGroups()
        notification()
        self.tableView.reloadData()
        photoService = PhotoService.init(container: tableView)
    }

    func notification(){
        token = sortedGroup.observe({ (changes: RealmCollectionChange) in
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
        tableView.endEditing(true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedGroup.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersGropus", for: indexPath) as! UsersGroupsTableViewCell
        let object = sortedGroup[indexPath.row]
        cell.setGroup(object: object)
        cell.groupAvatar.image = photoService?.photo(atIndexpath: indexPath, byUrl: object.groupAvatar)
        
        return cell
    }
}
