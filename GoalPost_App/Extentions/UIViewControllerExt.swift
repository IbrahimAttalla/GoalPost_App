//
//  UIViewControllerExt.swift
//  GoalPost_App
//
//  Created by Ibrahim Attalla on 5/17/18.
//  Copyright © 2018 Ibrahim Attalla. All rights reserved.
//

import UIKit


// in this class make animation to go and back between view controllers like navigation animation 

extension UIViewController{
    func PresentDetail(_ viewControllerToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
        
    }
    
    // this func doing that when we have 1 2 3 viewControllers when we move from 2 to 3 , when we dismess the 3ed viewController the 1st viewController well de presented not 2ed viewController cuase of 2ed view wes killed.... :(
    // so we call this func in the 2ed view when we move to the 3ed    ....ß
    
    func presentScondaryDetail (_ viewControllerToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        guard let presentedViewController = presentedViewController else{return}
        
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
        
        
    }
    
    
    func dismissDetail(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
               
    }
    
}
