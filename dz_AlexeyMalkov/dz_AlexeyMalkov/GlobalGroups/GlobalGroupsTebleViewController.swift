//
//  GlobalGroupsTebleViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

protocol GlobalGroupsTebleViewControllerDelegate: AnyObject {
    func didSelectGroupList(list: GroupList)
}

class GlobalGroupsTebleViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var sortedGroup = [GroupList]()
    var photoService: PhotoService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        photoService = PhotoService.init(container: tableView)
    }
    
    weak var delegate: GlobalGroupsTebleViewControllerDelegate?

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadGlobalGroups(searchText: searchText) { group in
            self.sortedGroup = group
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.endEditing(true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedGroup.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "globalGroups", for: indexPath) as! GlobalGroupsTableViewCell
        let object = sortedGroup[indexPath.row]
        cell.setGroup(object: object)
        cell.globalGroupAvatar.image = photoService?.photo(atIndexpath: indexPath, byUrl: object.groupAvatar)
        
        return cell
    }
    
}
