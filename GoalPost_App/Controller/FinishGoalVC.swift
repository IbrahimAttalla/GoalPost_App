//
//  FinishGoalVC.swift
//  GoalPost_App
//
//  Created by Ibrahim Attalla on 5/18/18.
//  Copyright © 2018 Ibrahim Attalla. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController  , UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextFiald: UITextField!
    
    var goaldescription : String!
    var goalType : GoalType!
    
    
    func initData(description : String , type : GoalType){
        self.goaldescription = description
        self.goalType = type
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKayboard()
        pointsTextFiald.delegate = self

    }
    @IBAction func createGoalBtnWespressed(_ sender: Any) {
        // pass data to coredata goal model
        if pointsTextFiald.text != "" {
            self.save( complition: { (complet) in
                if complet {
                    dismiss(animated: true, completion: nil)
                }
            })
        }
         
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pointsTextFiald.text = ""
    }
   
    @IBAction func backBTNWasPressed(_ sender: Any) {
         dismissDetail()
    }
    
    
    
    // save data into coredata

    func save(complition: (_ finished: Bool) ->()){
        // use an appdelegate opject
        guard let  managedContext = appDelegate?.persistentContainer.viewContext else{return}
        // get a Goal class (core data)
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goaldescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32( pointsTextFiald.text! )!
        goal.goalProgress = Int32(0)
        do{
            // here to save data into core data
       try managedContext.save()
            // to tell us whene ever the saveing is done or not
            print("saved successfully........!")
            complition(true)
        }
        catch{
            debugPrint("could not save \(error.localizedDescription)")
            // to tell us whene ever the saveing is done or not
            complition(false)
        }
        
        
        
        
        
        
    }
    
    
    
    
}
