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
    
    
    
    @IBOutlet weak var recentWorkoutsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recentWorkoutsTableView.delegate = self
        recentWorkoutsTableView.dataSource = self
    }
    
    

}
