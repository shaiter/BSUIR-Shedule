//
//  SettingsViewController.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/22/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if BSUIRSchedule.studentsSchedules.count == 0 {
            tableView.isHidden = true
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BSUIRSchedule.studentsSchedules.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentsSettingsTableViewCell") as! StudentsSettingsTableViewCell
        let schedule = BSUIRSchedule.studentsSchedules[indexPath.row]
        
        cell.studentsSchedule = schedule
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    @IBAction func unwindToSettings(sender: UIStoryboardSegue) {
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            if let subgroupSelectionViewController = sender.source as? SubgroupSelectionViewController {
                let numGroup = subgroupSelectionViewController.group!
                let subgroup = subgroupSelectionViewController.subGroup!
                if let studentsSchedule = BSUIRSchedule.getStudentsSchedule(numGroup: numGroup, subgroup: subgroup){
                    BSUIRSchedule.studentsSchedules.append(studentsSchedule)
                    BSUIRSchedule.selectedGroup = studentsSchedule.title
                    BSUIRSchedule.isNeedToReloadTitle = true
                    BSUIRSchedule.saveData()
                    DispatchQueue.main.async {
                        let newIndexPath = IndexPath(row: (BSUIRSchedule.studentsSchedules.count - 1), section: 0)
                        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                        self.tableView.isHidden = false
                    }
                }
                
            }
        }
        
        
        
        
        
        
    }

}
