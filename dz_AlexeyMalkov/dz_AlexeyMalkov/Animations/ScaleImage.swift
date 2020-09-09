//
//  ScaleImage.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 01.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

protocol ScaleImageDelegate: AnyObject {
    func needToSwipe(fromIndexPath: Int, fullscreen: UIImageView, usedIndexPath: Int)
}

class ScaleImage: UIImageView {
    
    weak var delegate: ScaleImageDelegate?
    var indexPathToUse: Int?
    var usedIndexPath: Int?
    
    fileprivate let imageTag = 35012
    var fullscreenImageView: UIImageView?
    var closeLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    fileprivate func setup() {
        self.isUserInteractionEnabled = true
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(showFullscreen))
        self.addGestureRecognizer(touchGesture)
    }
    
    fileprivate func createFullscreenPhoto() -> UIImageView {

        let tmpImageView = UIImageView(frame: self.frame)
        tmpImageView.image = self.image
        tmpImageView.contentMode = UIView.ContentMode.scaleAspectFit
        tmpImageView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        tmpImageView.tag = imageTag
        tmpImageView.alpha = 0.0
        tmpImageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideFullscreen))
        tmpImageView.addGestureRecognizer(tap)
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipingAnimation))
        tmpImageView.addGestureRecognizer(swipe)
        
        return tmpImageView
    }
    
    fileprivate func createLabel() -> UILabel {
        
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont(name: "HelveticaNeue", size: 12.0)
        label.sizeToFit()
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.textColor
        label.backgroundColor = UIColor.backgroundColor
        label.alpha = 0.0
        
        return label
    }
    
    @objc func showFullscreen() {
        
        let window = UIApplication.shared.windows.first!
        if window.viewWithTag(imageTag) == nil {
            
            self.fullscreenImageView = createFullscreenPhoto()
            self.closeLabel = createLabel()
           
            let labelWidth = window.frame.size.width
            let labelHeight = closeLabel.frame.size.height + 16
            self.closeLabel.frame =  CGRect.init(x: 0, y: window.frame.size.height - labelHeight, width: labelWidth, height: labelHeight)
            guard let nonEmptyFullScreenImageView = fullscreenImageView else { return }
            nonEmptyFullScreenImageView.addSubview(closeLabel)
            
            window.addSubview(nonEmptyFullScreenImageView)
            UIView.animate(withDuration: 0.4,
                           delay: 0.0,
                           options: .curveEaseInOut,
                           animations: {
                            nonEmptyFullScreenImageView.frame = window.frame
                            nonEmptyFullScreenImageView.alpha = 1
                            nonEmptyFullScreenImageView.layoutSubviews()
                            self.closeLabel.alpha = 1
                })
        }
    }
    
    @objc func hideFullscreen() {
        
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.fullscreenImageView?.frame = self.frame
                        self.fullscreenImageView?.alpha = 0
       
        }, completion: { finished in
                        self.fullscreenImageView?.removeFromSuperview()
                        self.fullscreenImageView = nil
        })
    }
    
    func swipeToImage(toImage: UIImage) {
        guard let fullScreen = self.fullscreenImageView else { return }
        UIView.transition(with: fullScreen,
                          duration: 0.33,
                          options: [.transitionFlipFromRight],
                          animations: {
                            fullScreen.image = toImage
        })
    }
    
    @objc func swipingAnimation(_ sender: UISwipeGestureRecognizer) {
        guard let nonEmtpyIndexPath = indexPathToUse, let nonEmptyUsedIndexPath = usedIndexPath, let nonEmptyFullScreenImageView = fullscreenImageView else { return }
        
        delegate?.needToSwipe(fromIndexPath: nonEmtpyIndexPath, fullscreen: nonEmptyFullScreenImageView, usedIndexPath: nonEmptyUsedIndexPath)
    }
}
