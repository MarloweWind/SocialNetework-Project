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
    
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "usersPhoto", for: indexPath) as! PhotoCellCollectionViewCell
        cell.userPhoto.image = photo
        cell.buttonLike.setImage(UIImage(named: "like1"), for: .normal)
        cell.buttonLike.setImage(UIImage(named: "like2"), for: .selected)
        let numberOfLikes: Int = 0;
        cell.labelLike.text = String(numberOfLikes)
        return cell
    }

}
