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
        cell.userPhoto.indexPathToUse = indexPath.row
        cell.userPhoto.usedIndexPath = 0
        cell.userPhoto.delegate = self
        
        return cell
    }
}

extension UsersPhotoCollectionViewController: ScaleImageDelegate {
    func needToSwipe(fromIndexPath: Int, fullscreen: UIImageView, usedIndexPath: Int) {
        let imageCounter = userImage.count - 1
        var indexPathToUse = 0
        
        if usedIndexPath < imageCounter {
            indexPathToUse = usedIndexPath + 1
        }
        
        let indexPath = IndexPath(row: fromIndexPath, section: 0)
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCellCollectionViewCell, let imageToUse = userImage[indexPathToUse] else { return }
        
        cell.userPhoto.usedIndexPath = indexPathToUse
        cell.userPhoto.fullscreenImageView = fullscreen
        cell.userPhoto.swipeToImage(toImage: imageToUse)
    }
}
