//
//  NewSongViewController.swift
//  Cycle-Trac
//
//  Created by Ryan DeBose-Boyd on 1/9/19.
//  Copyright © 2019 Ryan DeBose-Boyd. All rights reserved.
//

import UIKit

class NewSongViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    var pickerData: [Int] = [Int]()
    
    
    
    @IBOutlet weak var songTitleTextField: UITextField!
    
    @IBOutlet weak var songDurationPickerView: UIPickerView!
    
    @IBOutlet weak var songDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
       
        
        
        
        //Connect data:
        self.songDurationPickerView.delegate = self
        self.songDurationPickerView.dataSource = self

        // Do any additional setup after loading the view.
        pickerData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
         super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
    //Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //Number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count
    }
//    //Capture the picker view selection
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//    }
    
    //Considering which row its asking for and returning the data item that corresponds to that row
    
    private func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> Int {
        return pickerData[row]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
