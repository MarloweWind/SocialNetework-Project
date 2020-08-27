//
//  LikeView.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 17.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

class LikeView: UIControl {
    var flag = true
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
    let image = UIImage(systemName: "heart")
    var imageView = UIImageView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        uisetup()
    }
    required init?(coder:NSCoder){
        super.init(coder: coder)
        uisetup()
    }
    
    func uisetup(){
        label.text = "0"
        
        imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 21, height: 21))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        self.addSubview(label)
        self.addSubview(imageView)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        if flag {
            label.text = "1"
            imageView.tintColor = .red
            flag = false
            
            UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut],
                       animations: {
            self.label.frame.origin.y -= 10
            }) { (_) in
                UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: [.curveEaseInOut],
                           animations: {
                self.label.frame.origin.y += 10
            })
        }
        }else{
            label.text = "0"
            imageView.tintColor = .blue
            flag = true
        }
    }
    
}
