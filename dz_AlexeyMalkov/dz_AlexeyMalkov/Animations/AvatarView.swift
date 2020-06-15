//
//  AvatarView.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 17.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

class AvatarView: UIView {

    @IBInspectable
        var shadowColor: UIColor?{
            get {
                return UIColor(cgColor: layer.borderColor!)
            }
            set{
                layer.shadowColor = newValue?.cgColor
            }
        }

        @IBInspectable var shadowOpacity: Float = 1 {
            didSet {
                layer.shadowOpacity = shadowOpacity
            }
        }
        
        @IBInspectable var shadowRadius: CGFloat = 5  {
            didSet {
                layer.shadowRadius = shadowRadius
            }
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            layer.borderWidth = 0
            layer.borderColor = UIColor.black.cgColor
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            layer.cornerRadius = bounds.height / 2
            layer.shadowOffset = CGSize.zero
        }
    
    }

    class FriendAvatarImageView: UIImageView{
        override func layoutSubviews() {
            super.layoutSubviews()
            layer.cornerRadius = bounds.height / 2
        }
        
}
