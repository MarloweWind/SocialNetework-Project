//
//  GlobalGroupsTebleViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import FirebaseFirestore

protocol GlobalGroupsTebleViewControllerDelegate: AnyObject {
    func didSelectGroupList(list: Group)
}

class GlobalGroupsTebleViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var fbGroup: [Group] = []
    
    var sortedGroup = [GroupList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        db.collection("testGlobalGroups").getDocuments { (snapshot, error) in
            if let error = error{
                print(error.localizedDescription)
            } else {
                for document in snapshot!.documents{
                    let data = document.data()
                    self.fbGroup.append(Group(groupId: data["groupId"] as! Int, groupName: data["groupName"] as! String, groupAvatar: data["groupAvatar"] as! String, groupBanner: data["groupBanner"] as! String))
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    weak var delegate: GlobalGroupsTebleViewControllerDelegate?

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fbGroup.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "globalGroups", for: indexPath) as! GlobalGroupsTableViewCell
        let object = fbGroup[indexPath.row]
        cell.setGroup(object: object)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectGroupList(list: fbGroup[indexPath.row])
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
