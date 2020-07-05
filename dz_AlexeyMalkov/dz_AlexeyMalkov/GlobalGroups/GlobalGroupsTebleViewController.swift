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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadGlobalGroups(searchText: searchText) { group in
            self.sortedGroup = group
            self.tableView.reloadData()
        }
    }
    
    weak var delegate: GlobalGroupsTebleViewControllerDelegate?

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sortedGroup.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "globalGroups", for: indexPath) as! GlobalGroupsTableViewCell
        let object = sortedGroup[indexPath.row]
        cell.setGroup(object: object)
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        delegate?.didSelectGroupList(list: group[indexPath.row])
//        self.navigationController?.popToRootViewController(animated: true)
//    }
    
}
