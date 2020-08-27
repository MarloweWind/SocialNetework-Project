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
import PromiseKit

class FirstTabTableViewController: UITableViewController, UISearchBarDelegate {
    
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var fbUser: [Friend] = []
    var searchUser: [Friend] = []
    var searching = false
    var photoService: PhotoService?
        
    @IBOutlet weak var searchBar: UISearchBar!

    let user = realm.objects(UserListRealm.self)
    var sortedUsers = realm.objects(UserListRealm.self)
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        //loadFriends()
        //notification()
        let fbData = fbUserData()
        fbData.done { returnedFbUser in
            self.fbUser = returnedFbUser
            self.tableView.reloadData()
        }.catch { (error) in
            print(error.localizedDescription)
        }
        photoService = PhotoService(container: tableView)
    }
    
    func fbUserData() -> Promise<[Friend]> {
        let promise = Promise<[Friend]> { resolver in
            db.collection("testFriend").getDocuments { (snapshot, error) in
                if let error = error{
                    print(error.localizedDescription)
                    resolver.reject(error)
                } else {
                    var temporaryFbUser: [Friend] = []
                    for document in snapshot!.documents{
                        let data = document.data()
                        temporaryFbUser.append(Friend(id: data["id"] as! Int, firstName: data["firstName"] as! String, lastName: data["lastName"] as! String, avatar: data["avatar"] as! String, bdate: data["bdate"] as! String, usersPhoto: data["usersPhoto"] as! String))
                    }
                    resolver.fulfill(temporaryFbUser)
                }
            }
        }
        return promise
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
        searchUser = fbUser.filter({$0.lastName.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.endEditing(true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchUser.count
        } else {
            return fbUser.count
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if searching{
            if segue.identifier == "showProfile",
                let destinationVC = segue.destination as? UsersProfile,
                let indexPath = tableView.indexPathForSelectedRow{
                let user = searchUser[indexPath.row]
                let usersNameTitle = user.lastName + " " + user.firstName
                let url = URL(string: user.avatar)
                let usersName = user.lastName + " " + user.firstName
                let usersBirthDate = user.bdate
                let secondURL = URL(string: user.usersPhoto)
                destinationVC.title = usersNameTitle
                destinationVC.iamgeURL = url
                destinationVC.namedUser = usersName
                destinationVC.usersBdate = usersBirthDate
                destinationVC.photos = secondURL
            }
        } else {
            if segue.identifier == "showProfile",
                let destinationVC = segue.destination as? UsersProfile,
                let indexPath = tableView.indexPathForSelectedRow{
                let user = fbUser[indexPath.row]
                let usersNameTitle = user.lastName + " " + user.firstName
                let url = URL(string: user.avatar)
                let usersName = user.lastName + " " + user.firstName
                let usersBirthDate = user.bdate
                let secondURL = URL(string: user.usersPhoto)
                destinationVC.title = usersNameTitle
                destinationVC.iamgeURL = url
                destinationVC.namedUser = usersName
                destinationVC.usersBdate = usersBirthDate
                destinationVC.photos = secondURL
            }
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
        if searching {
            let object = searchUser[indexPath.row]
            cell.setUser(object: object)
            let fbImage = searchUser[indexPath.row]
            cell.avatarImageView.image = photoService?.photo(atIndexpath: indexPath, byUrl: fbImage.avatar)
        } else {
            let object = fbUser[indexPath.row]
            cell.setUser(object: object)
            let fbImage = fbUser[indexPath.row]
            cell.avatarImageView.image = photoService?.photo(atIndexpath: indexPath, byUrl: fbImage.avatar)
        }
        
        return cell
    }
}
