//
//  UsersProfile.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 29.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import Kingfisher

class UsersProfile: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var iamgeURL: URL?
    var namedUser: String?
    var id: Int = 0
    var photos = [Photo]()
    var usersBdate: String?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: FriendAvatarImageView!
    @IBOutlet weak var bdateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        nameLabel.text = namedUser
        bdateLabel.text = usersBdate
        avatarImage.kf.setImage(with: iamgeURL)
        loadPhotos(user_id: "\(id)") { photo in
            self.photos = photo
            self.collectionView.reloadData()
        }

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersProfileCell", for: indexPath) as! UsersProfileCell
            let object = photos[indexPath.row]
            cell.setImage(object: object)
        
            return cell
    }

}
