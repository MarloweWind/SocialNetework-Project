//
//  PhotoCellCollectionViewCell.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 14.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

class PhotoCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var labelLike: UILabel!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var ViewLike: LikeView!
    
    
    @IBAction func actionLikeButton(_ sender: Any) {
        if !buttonLike.isSelected {
            buttonLike.isSelected = true
            let t:Int? = Int(labelLike.text!)
            labelLike.text = String(t! + 1)
        }else{
            buttonLike.isSelected = false
            let t:Int? = Int(labelLike.text!)
            labelLike.text = String(t! - 1)
        }
    }
    
}
