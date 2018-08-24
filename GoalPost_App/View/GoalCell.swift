//
//  GoalCell.swift
//  GoalPost_App
//
//  Created by Ibrahim Attalla on 5/16/18.
//  Copyright © 2018 Ibrahim Attalla. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionlbl: UILabel!
    @IBOutlet weak var goalTypelbl: UILabel!
    @IBOutlet weak var goalProgresslbl: UILabel!
    
    @IBOutlet weak var completionView: UIView!
    
    func configureCell(goal: Goal){
        self.goalDescriptionlbl.text = goal.goalDescription
        self.goalTypelbl.text = goal.goalType
        self.goalProgresslbl.text = String( describing: goal.goalProgress)
        
        
        if goal.goalProgress == goal.goalCompletionValue {
            self.completionView.isHidden = false
        }
        else{
            self.completionView.isHidden = true
        }
        
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
