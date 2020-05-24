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
    
    var user: [UserList] = [
        UserList(name: "Святослав", avatar: UIImage(named: "1")!, userImage: UIImage(named: "21")!),
        UserList(name: "Лидия", avatar: UIImage(named: "2")!, userImage: UIImage(named: "22")!),
        UserList(name: "Юрий", avatar: UIImage(named: "3")!, userImage: UIImage(named: "23")!),
        UserList(name: "Зоя", avatar: UIImage(named: "4")!, userImage: UIImage(named: "24")!)
    ]
    var userIndex = ["Л", "З", "С", "Ю"]
    var filtered = [UserList]()
    var searching = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //серчбар
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = user.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searching {
            return filtered.count
        } else {
            return userIndex.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searching{
            return nil
        } else{
            return userIndex[section]
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return userIndex
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
           return filtered.count
        } else {
        
        var userRow = [UserList]()
        for a in user{
            if userIndex[section].contains(a.name.first!){
            userRow.append(a)
                }
            }
            return userRow.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var userRow = [UserList]()
        for a in user{
            if userIndex[indexPath.section].contains(a.name.first!){
            userRow.append(a)
            }
        }
        
        let passedImage = userRow[indexPath.row].userImage
        performSegue(withIdentifier: "fromTableToCollection", sender: passedImage)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromTableToCollection" {
            if let destinationVC = segue.destination as? UsersPhotoCollectionViewController, let passedImage = sender as? UIImage {
                destinationVC.photo = passedImage
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as! friendsTableViewCell
        if searching{
            cell.avatarImageView?.image = filtered[indexPath.row].avatar
            cell.nameLabel?.text = filtered[indexPath.row].name
        } else {
        var userRow = [UserList]()
        for a in user{
            if userIndex[indexPath.section].contains(a.name.first!){
            userRow.append(a)
                }
            }
        cell.avatarImageView.image = userRow[indexPath.row].avatar
        cell.nameLabel.text = userRow[indexPath.row].name
        }
        return cell
    }
    
}
