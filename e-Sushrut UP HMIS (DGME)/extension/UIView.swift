//
//  UIView.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 05/06/22.
//

import Foundation
import UIKit
extension UIView{
    
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        self.addSubview(backgroundView)
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
extension UITextField {

    //MARK:- Set Image on the right of text fields

  func setupRightImage(imageName:String){
    let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 13, height: 13))
    imageView.image = UIImage(named: imageName)
    let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    imageContainerView.addSubview(imageView)
    rightView = imageContainerView
    rightViewMode = .always
    self.tintColor = .lightGray
}

 //MARK:- Set Image on left of text fields

    func setupLeftImage(imageName:String){
       let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
       imageView.image = UIImage(named: imageName)
       let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
       imageContainerView.addSubview(imageView)
       leftView = imageContainerView
       leftViewMode = .always
       self.tintColor = .lightGray
     }

  }
extension UILabel {

    func set(text:String, leftIcon: UIImage? = nil, rightIcon: UIImage? = nil) {

        let leftAttachment = NSTextAttachment()
        leftAttachment.image = leftIcon
        leftAttachment.bounds = CGRect(x: 0, y: -2.5, width: 20, height: 20)
        if let leftIcon = leftIcon {
            leftAttachment.bounds = CGRect(x: 0, y: -2.5, width: leftIcon.size.width, height: leftIcon.size.height)
        }
        let leftAttachmentStr = NSAttributedString(attachment: leftAttachment)

        let myString = NSMutableAttributedString(string: "")

        let rightAttachment = NSTextAttachment()
        rightAttachment.image = rightIcon
        rightAttachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 20)
        let rightAttachmentStr = NSAttributedString(attachment: rightAttachment)


        if semanticContentAttribute == .forceRightToLeft {
            if rightIcon != nil {
                myString.append(rightAttachmentStr)
                myString.append(NSAttributedString(string: " "))
            }
            myString.append(NSAttributedString(string: text))
            if leftIcon != nil {
                myString.append(NSAttributedString(string: " "))
                myString.append(leftAttachmentStr)
            }
        } else {
            if leftIcon != nil {
                myString.append(leftAttachmentStr)
                myString.append(NSAttributedString(string: " "))
            }
            myString.append(NSAttributedString(string: text))
            if rightIcon != nil {
                myString.append(NSAttributedString(string: " "))
                myString.append(rightAttachmentStr)
            }
        }
        attributedText = myString
    }
}
extension UIView {
    func addPulsationAnimation() {
        /// transparency animation
        /// you can pick any values you like
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 1.5
        pulseAnimation.fromValue = 0.7
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(pulseAnimation, forKey: nil)
        
        /// transform scale animation
        /// you can pick any values you like
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 1.5
        scaleAnimation.fromValue = 0.95
        scaleAnimation.toValue = 1
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(scaleAnimation, forKey: nil)
    }
}

