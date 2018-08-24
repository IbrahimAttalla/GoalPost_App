//
//  ViewController.swift
//  GoalPost_App
//
//  Created by Ibrahim Attalla on 5/16/18.
//  Copyright © 2018 Ibrahim Attalla. All rights reserved.
//

import UIKit
import CoreData

// this code for create an object form  my appdelegate class to help me using it allover all classes
 let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var goals : [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // create an object of core data
//        let goal = Goal()
//        goal.goalCompletionValue = Int32(exactly: 12.0)!
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // we create the func outside this method to call it allover this class and get it's data
//        self.fetch { (complete) in
//            if complete{
//                if goals.count >= 1 {
//                    tableView.isHidden = false
//                }else{
//                    tableView.isHidden = true
//                }
//            }
//        }
        
       //  call the fetch func to get data
        fetchCoreDataObject()
        tableView.reloadData()
    }
    
    func fetchCoreDataObject() {
        self.fetch { (complete) in
            if complete{
                if goals.count >= 1 {
                    tableView.isHidden = false
                }else{
                    tableView.isHidden = true
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        //here we call the view controller by it's id not the segue id
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {
            return
        }
        //this part is belongs to guard condtion
        PresentDetail(createGoalVC)
    }
    
}
extension GoalsVC : UITableViewDelegate , UITableViewDataSource{
    
    //the following 3 func related to tableView designe
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell
            else { return UITableViewCell()}
        
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
        
    }
   
    
    // tha following  funcs retaled to delete func designe
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     return( true )
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        // return UITableViewCellEditingStyle.none  .... to do custom configeration here select none
        return .none
    }
    
    //    and  here we create eidting action becuase we select none before
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // define deleteAction and it's oprations
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            // we call remove func to delete date from core data
            self.removeGoal(atIndexPath: indexPath)
            // we call fetch func to get date from coredata again after remove some date
           self.fetchCoreDataObject()
            // to delete the row form tableview designe with animation move
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        // define addAction and it's oprations
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }

        deleteAction.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        // here we return multible Action that we defined it befor
        return [deleteAction , addAction]
    }
}
extension GoalsVC {
    // to check the progress completionlable
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Successfully set progress!")
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
   
   // to get data from coredata and put it into tableView
    func fetch(completion: (_ complete : Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        // getting Goal model 
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
          goals = try managedContext.fetch(fetchRequest)
            print("successfully fetched data ")
            completion(true)
        }catch{
            debugPrint("Could not fetch : \(error.localizedDescription)")
            completion(false)
        }
    }
    // to remove goal form coredata and tableView
    func removeGoal(atIndexPath indexPath: IndexPath){
        guard let manageContext = appDelegate?.persistentContainer.viewContext else{return}
        manageContext.delete(goals[indexPath.row])
        do {
            try manageContext.save()
            print("successfully removed goal ..! ")
        }catch{
            debugPrint("could not remove : \(error.localizedDescription) " )
        }
        
    }
    
    
   
    
}











