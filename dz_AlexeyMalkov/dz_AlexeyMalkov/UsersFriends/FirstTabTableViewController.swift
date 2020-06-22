//
//  FirstTabTableViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 02.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

class FirstTabTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var networkService = NetworkService()
    
    var user = [UserList]()
    var sectionIndexTitles: [String] = []
    var sortedUsers = [Character: [UserList]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sortedUsers = sort(friends: user)
        searchBar.delegate = self
        
        networkService.loadFriends(userId: UserSession.shared.userId) { user in
            self.sortedUsers = self.sort(friends: user)
            self.tableView.reloadData()
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
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! friendsTableViewCell
//
//        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
//        cell.avatarImageView.transform = scale
//        cell.avatarImageView.alpha = 0.5
//
//        UIView.animate(withDuration: 0.5,
//                       delay: 0,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 0,
//                       options: [.curveEaseInOut],
//                       animations: {
//                        cell.avatarImageView.transform = .identity
//                        cell.avatarImageView.alpha = 1
//
//        }, completion: { finished in
//            guard finished else { return }
//
//            if self.searching {
//                let passedImage = self.filtered[indexPath.row].userImage
//                self.performSegue(withIdentifier: "fromTableToCollection", sender: passedImage)
//            } else {
//                var userRow = [UserList]()
//
//                for a in self.user {
//                    if self.userIndex[indexPath.section].contains(a.name.first!){
//                        userRow.append(a)
//                    }
//                }
//
//                let passedImage = userRow[indexPath.row].userImage
//                self.performSegue(withIdentifier: "fromTableToCollection", sender: passedImage)
//            }
//        })
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "fromTableToCollection" {
//            if let destinationVC = segue.destination as? UsersPhotoCollectionViewController{
//                    if searching{
//                        if let indexPath = tableView.indexPathForSelectedRow{
//                            destinationVC.userImage = filtered[indexPath.row].userImage
//                        }
//                    } else {
//
//                    if let indexPath = tableView.indexPathForSelectedRow{
//                        var userRow = [UserList]()
//                        for a in user{
//                        if userIndex[indexPath.section].contains(a.name.first!){
//                        userRow.append(a)
//                            }
//                        }
//                        destinationVC.userImage = userRow[indexPath.row].userImage
//                        }
//                    }
//            }
//        }
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as! friendsTableViewCell
        
        let firstCharUsers = sortedUsers.keys.sorted()[indexPath.section]
        let users = sortedUsers[firstCharUsers]!
        let user: UserList = users[indexPath.row]
        cell.nameLabel.text = user.lastName + " " + user.firstName

        return cell
    }
}
