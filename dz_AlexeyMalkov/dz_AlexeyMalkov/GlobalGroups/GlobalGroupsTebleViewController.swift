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

class GlobalGroupsTebleViewController: UITableViewController {

    var group: [GroupList] = [
    GroupList(groupName: "Фанаты GIF", groupAvatar: UIImage(named: "41")!),
    GroupList(groupName: "Группа RST", groupAvatar: UIImage(named: "42")!),
    ]
    
    weak var delegate: GlobalGroupsTebleViewControllerDelegate?

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return group.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "globalGroups", for: indexPath) as! GlobalGroupsTableViewCell
        cell.globalGroupAvatar.image = group[indexPath.row].groupAvatar
        cell.globalGroupName.text = group[indexPath.row].groupName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectGroupList(list: group[indexPath.row])
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
