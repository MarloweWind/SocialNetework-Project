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
    
    var networkService = NetworkService()
    var iamgeURL: URL?
    var namedUser: String?
    var user: UserList?
    var photos = [Photo]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: FriendAvatarImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        nameLabel.text = namedUser
        
        avatarImage.kf.setImage(with: iamgeURL)
        networkService.loadPhotos(userId: user!.id) { photos in
            self.photos = photos
            self.collectionView.reloadData()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "UsersProfileCell", for: indexPath) as? UsersProfileCell else { preconditionFailure("FriendsCell can't be dequeued")}
        let photo = photos[indexPath.item]
        if let size = photo.sizes.first, let url = URL(string: size.url) {
            cell.photoImage.kf.setImage(with: url)
        }
//        let photo = photos[indexPath.item]
//        let size = photo.sizes.first
//        let url = URL(string: size!.url)
//        cell.photoImage.kf.setImage(with: url)
        
        
        return cell
        
    }
    
}
