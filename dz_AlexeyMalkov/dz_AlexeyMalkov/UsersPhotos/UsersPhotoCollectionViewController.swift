//
//  UsersPhotoCollectionViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class UsersPhotoCollectionViewController: UICollectionViewController {
    
    var userImage = [UIImage?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userImage.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "usersPhoto", for: indexPath) as! PhotoCellCollectionViewCell
        let photo = userImage[indexPath.row]
        cell.userPhoto.image = photo
        
        return cell
    }
}
