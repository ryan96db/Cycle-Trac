//
//  NewSongViewController.swift
//  Cycle-Trac
//
//  Created by Ryan DeBose-Boyd on 1/9/19.
//  Copyright © 2019 Ryan DeBose-Boyd. All rights reserved.
//

import UIKit
import CoreData

class NewSongViewController: UIViewController, UITextFieldDelegate  {
    
    
    
    
    var songsCoreData = [Song]()
    
//    var workoutsVC : NewWorkoutViewController? = nil
    
    
    @IBOutlet weak var songTitleTextField: UITextField!
    
    @IBOutlet weak var songDurationTextField: UITextField!
    
    @IBOutlet weak var songDescriptionTextView: UITextView!
    
    @IBAction func addNewSong(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newSong = Song(context: context)
            
            
            
            if let songTitle = songTitleTextField.text {
                newSong.title = songTitle
            }
            
            if let songDuration = songDurationTextField.text {
                newSong.duration = Double(songDuration)!
            }
            
            if let songDescription = songDescriptionTextView.text {
                newSong.summary = songDescription
            }
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.songTitleTextField.delegate = self
        self.songDurationTextField.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        songDurationTextField.resignFirstResponder()
        songDescriptionTextView.resignFirstResponder()
        
    }
    func textFieldShouldReturn(_ songTitleTextField: UITextField) -> Bool {
        songTitleTextField.resignFirstResponder()
        
        return true
    }
    
    //    private func textFieldShouldReturn(_ songDurationTextField: UITextField) -> Bool {
    //        songDurationTextField.resignFirstResponder()
    //        return true
    //    }
    
    
}
