//
//  NewWorkoutViewController.swift
//  Cycle-Trac
//
//  Created by Ryan DeBose-Boyd on 1/15/19.
//  Copyright © 2019 Ryan DeBose-Boyd. All rights reserved.
//

import UIKit
import CoreData



class NewWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    var songsCoreData = [Song]()
    
    var workout = Workout()
    
    @IBOutlet weak var workoutSongs: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        workoutSongs.delegate = self
        workoutSongs.dataSource = self
        
        workoutSongs.reloadData()
        getSongs()
    }
    
    
    func getSongs() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let songsFromCoreData = try?context.fetch(Song.fetchRequest()) {
                
                if let songs = songsFromCoreData as? [Song]
                {
                    songsCoreData = songs
                
                    workoutSongs.reloadData()
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
            context.delete(songsCoreData[indexPath.row])
            songsCoreData.remove(at: indexPath.row)
            self.workoutSongs.deleteRows(at: [indexPath], with: .automatic)
            
        }
            
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsCoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let currentSong = songsCoreData[indexPath.row]
        
        cell.textLabel?.text = currentSong.title
        
        return cell
    }

}
