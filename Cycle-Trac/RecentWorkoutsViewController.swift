//
//  RecentWorkoutsViewController.swift
//  Cycle-Trac
//
//  Created by Ryan DeBose-Boyd on 1/15/19.
//  Copyright © 2019 Ryan DeBose-Boyd. All rights reserved.
//

import UIKit

class RecentWorkoutsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
    @IBAction func createNewWorkout(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add New Workout", message: "Enter a new workout name.", preferredStyle: .alert)
        
        alertController.addTextField { (textField: UITextField) -> Void in
            textField.placeholder = "Enter Workout Name"
            textField.textAlignment = .center
            
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: {
            alert -> Void in
            
            let workoutNameField = alertController.textFields![0] as UITextField
            
            if workoutNameField.text != "" {
                if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                    let newWorkout = Workout(context: context)
                    
                    //Unwraps workoutNameField
                    if let name = workoutNameField.text
                    {
                        newWorkout.name = name
                        
                        //                performSegue(withIdentifier: "moveToNewWorkoutViewController", sender: workoutItem)
                        
                    }

                }
            }
            else {
                let errorAlert = UIAlertController(title: "Error", message: "Please enter a new workout name.", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    self.present(alertController, animated: true, completion: nil)
                }))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }))
        
        
        self.present(alertController, animated: true)
    }
    
    @IBOutlet weak var recentWorkoutsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recentWorkoutsTableView.delegate = self
        recentWorkoutsTableView.dataSource = self
    }
    
    

}
