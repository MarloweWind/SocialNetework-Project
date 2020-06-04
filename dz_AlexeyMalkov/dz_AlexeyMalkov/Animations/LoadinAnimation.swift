//
//  LoadinAnimation.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 27.05.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

class LoadinAnimation: UIView {

    var circles = [CALayer]()
    let containerView = UIView()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        
        let circlesCount = 3
        let side: CGFloat = 10
        let offset: CGFloat = 5
        print(bounds.width)
        let x: CGFloat = 0
        let circleColor = UIColor.gray
        
        for i in 0..<circlesCount {
            let circle = CAShapeLayer()
            circle.opacity = 1
            circle.path = UIBezierPath(ovalIn: CGRect(x: x + (side + offset)*CGFloat(i),
            y: 10 ,
            width: side,
            height: side)).cgPath
            circle.fillColor = circleColor.cgColor
            containerView.layer.addSublayer(circle)
            circles.append(circle)
        }
        containerView.center = CGPoint(x: (bounds.width / 2) - 20, y: bounds.height / 2 )
        addSubview(containerView)
        startAnimating()
    }
    
    private func startAnimating() {
        var offset: TimeInterval = 0.0
        circles.forEach {
            $0.removeAllAnimations()
            $0.add(scaleAnimation(offset), forKey: nil)
            offset = offset + 0.10
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    private func scaleAnimation(_ after: TimeInterval = 0) -> CAAnimationGroup {
        let scaleDown = CABasicAnimation(keyPath: "opacity")
        scaleDown.beginTime = after
        scaleDown.fromValue = 0.1
        scaleDown.toValue = 1.0
        scaleDown.duration = 2
        scaleDown.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        let group = CAAnimationGroup()
        group.animations = [scaleDown]
        group.repeatCount = Float.infinity
        group.autoreverses = false
        
        group.duration = CFTimeInterval(1)

        return group
    }
}
