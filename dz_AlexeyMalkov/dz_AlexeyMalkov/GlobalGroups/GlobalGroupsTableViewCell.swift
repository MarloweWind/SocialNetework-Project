//
//  GlobalGroupsTableViewCell.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

class GlobalGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var globalGroupAvatar: UIImageView!
    @IBOutlet weak var globalGroupName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setGroup (object: GroupList){
        self.globalGroupName.text = object.groupName
    }
}
