//
//  RecentWorkoutsViewController.swift
//  Cycle-Trac
//
//  Created by Ryan DeBose-Boyd on 1/15/19.
//  Copyright © 2019 Ryan DeBose-Boyd. All rights reserved.
//

import UIKit

class RecentWorkoutsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var recentWorkouts: UITableView!
    var recentWorkoutsCoreData = [Workout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recentWorkouts.delegate = self
        recentWorkouts.dataSource = self
        
        getRecentWorkouts()
        
        recentWorkouts.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recentWorkouts.delegate = self
        recentWorkouts.dataSource = self
        
        getRecentWorkouts()
        
        recentWorkouts.reloadData()
    }
    
    func getRecentWorkouts()
    {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let recentWorkoutsFromCoreData = try?context.fetch(Workout.fetchRequest()) {
                
                if let workouts = recentWorkoutsFromCoreData as? [Workout]
                {
                    recentWorkoutsCoreData = workouts
                    
                    recentWorkouts.reloadData()
                }
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentWorkoutsCoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let currentWorkout = recentWorkoutsCoreData[indexPath.row]
        
        cell.textLabel?.text = currentWorkout.name! + "\t\t\t\t\t\t\t" + currentWorkout.date!
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
                        
                        let day = Date()
                        let dayFormatter = DateFormatter()
                        dayFormatter.dateFormat = "EEE"
                        let dayofWeek = dayFormatter.string(from: day)
                        
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .medium
                        
                        let dateString = "\(dayofWeek), \(dateFormatter.string(from: Date() as Date))"
                        
                        newWorkout.date = dateString
                        
                        self.performSegue(withIdentifier: "moveToNewWorkoutViewController", sender: newWorkout)
                        
                    }
                    
                    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "moveToNewWorkoutViewController"{
            if let workoutVC = segue.destination as? NewWorkoutViewController
            {
                if let selectedWorkout = sender as? Workout {
                    workoutVC.workout = selectedWorkout
                    
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if editingStyle == UITableViewCell.EditingStyle.delete {
                context.delete(recentWorkoutsCoreData[indexPath.row])
                recentWorkoutsCoreData.remove(at: indexPath.row)
                self.recentWorkouts.deleteRows(at: [indexPath], with: .automatic)
                
            }
            
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}
