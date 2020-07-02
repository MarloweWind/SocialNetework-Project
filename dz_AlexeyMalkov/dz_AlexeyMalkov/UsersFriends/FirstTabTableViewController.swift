//
//  FirstTabTableViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 02.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class FirstTabTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var networkService = NetworkService()
    var dataBase = DataService()
    
    var user = [UserList]()
    var sectionIndexTitles: [String] = []
    var sortedUsers = [Character: [UserList]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sortedUsers = sort(friends: user)
        searchBar.delegate = self
        let cachedUser = dataBase.users()
        let sinceLastUpdate = networkService.timeintervalSinceLastUpdate(for: UserList.className())
        if cachedUser.isEmpty || sinceLastUpdate > 3600 {
            networkService.loadFriends(userId: UserSession.shared.userId) { user in
                self.sortedUsers = self.sort(friends: user)
                self.user = user
                self.tableView?.reloadData()
            }
        } else {
            self.sortedUsers = self.sort(friends: cachedUser)
            self.user = cachedUser
            self.tableView?.reloadData()
        }
        
    }

    //серчбар
    private func sort(friends: [UserList], prefix: String = "") ->[Character: [UserList]] {
        var userDict = [Character: [UserList]]()

        friends.forEach { user in
            guard let firstCharUsers = user.lastName.first else { return }
            if !prefix.isEmpty && !user.lastName.lowercased().contains(prefix.lowercased()) {
                return
            }
            if var thisCharUsers = userDict[firstCharUsers] {
                thisCharUsers.append(user)
                userDict[firstCharUsers] = thisCharUsers.sorted(by: { $0.lastName < $1.lastName })
            } else {
                userDict[firstCharUsers] = [user]
            }
        }
        return userDict
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.sortedUsers = sort(friends: user)
        tableView.reloadData()
        if searchText == "" {
            viewDidLoad()
        } else {
            self.sortedUsers = sort(friends: user)
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.reloadData()
        viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedUsers.keys.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let firstCharUsers = sortedUsers.keys.sorted()[section]
        return String(firstCharUsers)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let firstCharUsers = sortedUsers.keys.sorted()
        return firstCharUsers.map({ String($0) })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keysSorted = sortedUsers.keys.sorted()
        return sortedUsers[keysSorted[section]]?.count ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfile",
            let destinationVC = segue.destination as? UsersProfile,
            let indexPath = tableView.indexPathForSelectedRow {
            let firstCharUsers = sortedUsers.keys.sorted()[indexPath.section]
            let users = sortedUsers[firstCharUsers]!
            let user = users[indexPath.row]
            let usersNameTitle = user.lastName + user.firstName
            let url = URL(string: user.avatar)
            let usersName = user.lastName + " " + user.firstName
            destinationVC.title = usersNameTitle
            destinationVC.iamgeURL = url
            destinationVC.namedUser = usersName
            destinationVC.user = user
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! friendsTableViewCell
        
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        cell.avatarImageView.transform = scale
        cell.avatarImageView.alpha = 0.5

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut],
                       animations: {
                        cell.avatarImageView.transform = .identity
                        cell.avatarImageView.alpha = 1
                        
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as! friendsTableViewCell
        
        let firstCharUsers = sortedUsers.keys.sorted()[indexPath.section]
        let users = sortedUsers[firstCharUsers]!
        let user: UserList = users[indexPath.row]
        cell.nameLabel.text = user.lastName + " " + user.firstName
        let url = URL(string: user.avatar)
        cell.avatarImageView.kf.setImage(with: url)
        
        return cell
    }
}
