//
//  UsersProfileCell.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 29.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

class UsersProfileCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: ScaleImage!
    @IBOutlet weak var viewLike: LikeView!
    
    func setImage(object: Photo){
           let url = URL(string: object.photo_1280)
           self.photoImage.kf.setImage(with: url)
       }
}
