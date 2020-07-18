//
//  UsersProfile.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 29.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Kingfisher

class UsersProfile: UIViewController{
    
    var iamgeURL: URL?
    var namedUser: String?
//    var id: Int = 0
    var photos: URL?
    var usersBdate: String?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: FriendAvatarImageView!
    @IBOutlet weak var bdateLabel: UILabel!
    @IBOutlet weak var usersImage: ScaleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = namedUser
        bdateLabel.text = usersBdate
        avatarImage.kf.setImage(with: iamgeURL)
        usersImage.kf.setImage(with: photos)
    }

}
