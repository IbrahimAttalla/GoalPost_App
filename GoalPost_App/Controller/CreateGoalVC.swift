//
//  CreateGoalVC.swift
//  GoalPost_App
//
//  Created by Ibrahim Attalla on 5/17/18.
//  Copyright © 2018 Ibrahim Attalla. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController , UITextViewDelegate {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
       var goalType: GoalType = .ShortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTextView.delegate = self
        // from class UIViewEXt
        nextBtn.bindToKayboard()
        // from class UIButton
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeSelectedColor()
    
    }
    // this func doen when the textview was pressed
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    @IBAction func shorttermBtnWasPressed(_ sender: Any) {
        goalType = .ShortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeSelectedColor()
        
    }
    

    @IBAction func longTremBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        shortTermBtn.setDeSelectedColor()
        longTermBtn.setSelectedColor()
    }

    @IBAction func nextBtnWasPressed(_ sender: Any) {
// this code check if the textview is empty or not and move to FinishGoalVC by it's ID not segue
        if goalTextView.text != "" && goalTextView.text != "what is your goal ..?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC")  as? FinishGoalVC  else {return}
        finishGoalVC.initData(description: goalTextView.text!, type: goalType)
            // this func from UIViewControllerExt class to mack animation
              //PresentDetail(finishGoalVC)
            // but the following code to dismess this view controller .. and remove away
            presentingViewController?.presentScondaryDetail(finishGoalVC)
            
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        // this func from UIViewControllerExt class to mack animation
        dismissDetail()
    }
    
    
    
    
}
