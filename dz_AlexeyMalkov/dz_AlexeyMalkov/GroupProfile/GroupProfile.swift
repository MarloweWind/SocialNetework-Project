//
//  GroupProfile.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 20.07.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Kingfisher

class GroupProfile: UIViewController{
    
    @IBOutlet weak var groupBanner: UIImageView!
    @IBOutlet weak var groupProfileAvatar: FriendAvatarImageView!    
    @IBOutlet weak var groupProfileLabel: UILabel!
    
    var namedGroup: String?
    var groupAva: URL?
    var groupBan: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupProfileLabel.text = namedGroup
        groupProfileAvatar.kf.setImage(with: groupAva)
        groupBanner.kf.setImage(with: groupBan)
    }
    
}
