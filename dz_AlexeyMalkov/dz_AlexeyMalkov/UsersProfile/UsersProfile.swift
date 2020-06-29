//
//  UsersProfile.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 29.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Kingfisher

class UsersProfile: UIViewController {
    
    var networkService = NetService()
    var iamgeURL: URL?
    var namedUser: String?
    var user: UserList?
    var photos = [Photo]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: FriendAvatarImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.delegate = self
        nameLabel.text = namedUser
        avatarImage.kf.setImage(with: iamgeURL)
        
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photos.count
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
    
    
}
