//
//  SecondTabTableViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import FirebaseFirestore

class SecondTabTableViewController: UITableViewController, UISearchBarDelegate {
    
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var fbGroup: [Group] = []
    var searchGroup: [Group] = []
    var searching = false
    let myQueue = OperationQueue()
    var photoService: PhotoService?

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        fbGroupData()
        photoService = PhotoService(container: tableView)
    }
    
    func fbGroupData(){
        myQueue.addOperation { [weak self] in
            self?.db.collection("testGroup").getDocuments { (snapshot, error) in
                if let error = error{
                    print(error.localizedDescription)
                } else {
                    var counter = 0
                    for document in snapshot!.documents{
                        let data = document.data()
                        self?.fbGroup.append(Group(groupId: data["groupId"] as! Int, groupName: data["groupName"] as! String, groupAvatar: data["groupAvatar"] as! String, groupBanner: data["groupBanner"] as! String))
                        counter += 1
                        if counter == snapshot?.documents.count{
                            OperationQueue.main.addOperation { [weak self] in
                                self?.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchGroup = fbGroup.filter({$0.groupName.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.endEditing(true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if searching{
                searchGroup.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                fbGroup.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGroup", let globalGroupsTebleViewController = segue.destination as? GlobalGroupsTebleViewController {
            globalGroupsTebleViewController.delegate = self
        }
        if searching {
            if segue.identifier == "showGroupProfile",
                let destinationVC = segue.destination as? GroupProfile,
                let indexPath = tableView.indexPathForSelectedRow{
                let group = searchGroup[indexPath.row]
                let groupTitle = group.groupName
                let url = URL(string: group.groupAvatar)
                let groupName = group.groupName
                let secondURL = URL(string: group.groupBanner)
                destinationVC.title = groupTitle
                destinationVC.groupAva = url
                destinationVC.namedGroup = groupName
                destinationVC.groupBan = secondURL
            }
        } else {
            if segue.identifier == "showGroupProfile",
                let destinationVC = segue.destination as? GroupProfile,
                let indexPath = tableView.indexPathForSelectedRow{
                let group = fbGroup[indexPath.row]
                let groupTitle = group.groupName
                let url = URL(string: group.groupAvatar)
                let groupName = group.groupName
                let secondURL = URL(string: group.groupBanner)
                destinationVC.title = groupTitle
                destinationVC.groupAva = url
                destinationVC.namedGroup = groupName
                destinationVC.groupBan = secondURL
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchGroup.count
        } else {
            return fbGroup.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UsersGroupsTableViewCell
        
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        cell.groupAvatar.transform = scale
        cell.groupAvatar.alpha = 0.5

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut],
                       animations: {
                        cell.groupAvatar.transform = .identity
                        cell.groupAvatar.alpha = 1
                        
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersGropus", for: indexPath) as! UsersGroupsTableViewCell
        if searching{
            let object = searchGroup[indexPath.row]
            cell.setGroup(object: object)
            cell.groupAvatar.image = photoService?.photo(atIndexpath: indexPath, byUrl: object.groupAvatar)
        } else {
            let object = fbGroup[indexPath.row]
            cell.setGroup(object: object)
            cell.groupAvatar.image = photoService?.photo(atIndexpath: indexPath, byUrl: object.groupAvatar)
        }
        
        return cell
    }
}

extension SecondTabTableViewController: GlobalGroupsTebleViewControllerDelegate {    
    func didSelectGroupList(list: Group) {
        if searching{
            searchGroup.append(list)
            tableView.reloadData()
        } else {
            fbGroup.append(list)
            tableView.reloadData()
        }
    }
}
