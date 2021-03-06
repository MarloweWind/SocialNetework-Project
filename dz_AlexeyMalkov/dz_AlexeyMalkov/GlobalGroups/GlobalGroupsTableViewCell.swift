//
//  GlobalGroupsTableViewCell.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Kingfisher

class GlobalGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var globalGroupAvatar: UIImageView!
    @IBOutlet weak var globalGroupName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setGroup (object: Group){
        let url = URL(string: object.groupAvatar)
        self.globalGroupName.text = object.groupName
        self.globalGroupAvatar.kf.setImage(with: url)
    }
}
