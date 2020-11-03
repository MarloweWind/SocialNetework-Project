//
//  FirstTabTableViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 02.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import RealmSwift

class FirstTabTableViewController: UITableViewController, UISearchBarDelegate {

        
    @IBOutlet weak var searchBar: UISearchBar!

    let user = realm.objects(UserListRealm.self)
    var sortedUsers = realm.objects(UserListRealm.self)
    var token: NotificationToken?
    var photoService: PhotoService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        loadFriends()
        notification()
        self.tableView.reloadData()
        photoService = PhotoService.init(container: tableView)
    }
    
    func notification(){
            token = sortedUsers.observe({ (changes: RealmCollectionChange) in
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
        guard !searchText.isEmpty else {
            sortedUsers = user
            tableView.reloadData()
            return
        }
        sortedUsers = user.filter(" lastName BEGINWITH '\(searchBar.text!)'")
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.endEditing(true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as! friendsTableViewCell
        let object = sortedUsers[indexPath.row]
        cell.setUser(object: object)
        cell.avatarImageView.image = photoService?.photo(atIndexpath: indexPath, byUrl: object.avatar)
        
        return cell
    }
}
