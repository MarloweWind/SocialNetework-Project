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
import FirebaseFirestore

class FirstTabTableViewController: UITableViewController, UISearchBarDelegate {
    
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var fbUser: [Friend] = []
    
    @IBOutlet weak var searchBar: UISearchBar!

    let user = realm.objects(UserListRealm.self)
    var sortedUsers = realm.objects(UserListRealm.self)
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        //loadFriends()
        self.tableView.reloadData()
        //notification()
        
        db.collection("testFriend").getDocuments { (snapshot, error) in
            if let error = error{
                print(error.localizedDescription)
            } else {
                for document in snapshot!.documents{
                    let data = document.data()
                    self.fbUser.append(Friend(id: data["id"] as! Int, firstName: data["firstName"] as! String, lastName: data["lastName"] as! String, avatar: data["avatar"] as! String, bdate: data["bdate"] as! String))
                    self.tableView.reloadData()
                }
            }
        }
        
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fbUser.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfile",
            let destinationVC = segue.destination as? UsersProfile,
            let indexPath = tableView.indexPathForSelectedRow{
            let user = fbUser[indexPath.row]
            let usersNameTitle = user.lastName + " " + user.firstName
            let url = URL(string: user.avatar)
            let usersName = user.lastName + " " + user.firstName
            let usersBirthDate = user.bdate
            destinationVC.title = usersNameTitle
            destinationVC.iamgeURL = url
            destinationVC.namedUser = usersName
            destinationVC.usersBdate = usersBirthDate
            
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
        let object = fbUser[indexPath.row]
        cell.setUser(object: object)
        
        return cell
    }
}
struct Friend {
    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var avatar: String = ""
    var bdate: String = ""
    var usersPhoto: String = ""
}
