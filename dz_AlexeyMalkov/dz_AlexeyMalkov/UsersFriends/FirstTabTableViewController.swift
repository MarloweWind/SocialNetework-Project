//
//  FirstTabTableViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 02.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

class FirstTabTableViewController: UITableViewController {

    var user: [UserList] = [
        UserList(name: "Святослав", avatar: UIImage(named: "1")!, userImage: UIImage(named: "21")!),
        UserList(name: "Лидия", avatar: UIImage(named: "2")!, userImage: UIImage(named: "22")!),
        UserList(name: "Юрий", avatar: UIImage(named: "3")!, userImage: UIImage(named: "23")!),
        UserList(name: "Зоя", avatar: UIImage(named: "4")!, userImage: UIImage(named: "24")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passedImage = user[indexPath.row].userImage
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
        cell.avatarImageView.image = user[indexPath.row].avatar
        cell.nameLabel.text = user[indexPath.row].name
        
        return cell
    }



}
