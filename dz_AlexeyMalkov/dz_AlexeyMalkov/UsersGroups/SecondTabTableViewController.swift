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
import FirebaseFirestore

class SecondTabTableViewController: UITableViewController, UISearchBarDelegate {
    
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var fbGroup: [Group] = []

    @IBOutlet weak var searchBar: UISearchBar!
    
    var token: NotificationToken?
    
    let group = realm.objects(GroupListRealm.self)
    var sortedGroup = realm.objects(GroupListRealm.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        //loadUserGroups()
        self.tableView.reloadData()
        //notification()
        
        db.collection("testGroup").getDocuments { (snapshot, error) in
            if let error = error{
                print(error.localizedDescription)
            } else {
                for document in snapshot!.documents{
                    let data = document.data()
                    self.fbGroup.append(Group(groupId: data["groupId"] as! Int, groupName: data["groupName"] as! String, groupAvatar: data["groupAvatar"] as! String))
                    self.tableView.reloadData()
                }
            }
        }
        
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fbGroup.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGroup", let globalGroupsTebleViewController = segue.destination as? GlobalGroupsTebleViewController {
            globalGroupsTebleViewController.delegate = self
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fbGroup.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersGropus", for: indexPath) as! UsersGroupsTableViewCell
        let object = fbGroup[indexPath.row]
        cell.setGroup(object: object)
        
        return cell
    }
}

extension SecondTabTableViewController: GlobalGroupsTebleViewControllerDelegate {    
    func didSelectGroupList(list: Group) {
        fbGroup.append(list)
        tableView.reloadData()
    }
}
struct Group {
    var groupId: Int = 0
    var groupName: String = ""
    var groupAvatar: String = ""
}
