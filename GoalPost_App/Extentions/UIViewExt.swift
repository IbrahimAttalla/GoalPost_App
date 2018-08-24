//
//  UIViewExt.swift
//  GoalPost_App
//
//  Created by Ibrahim Attalla on 5/17/18.
//  Copyright © 2018 Ibrahim Attalla. All rights reserved.
//

import UIKit


extension UIView {
    func bindToKayboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
            }
    @objc func keyboardWillChange(_ notification : NSNotification){
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let startingFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endingFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as!NSValue).cgRectValue
        let deltay = endingFrame.origin.y - startingFrame.origin.y
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions (rawValue: curve), animations: {self.frame.origin.y+=deltay}, completion: nil)
        
        
    }
    
    
}
