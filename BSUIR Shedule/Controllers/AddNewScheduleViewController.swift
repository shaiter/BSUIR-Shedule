//
//  AddNewScheduleTableViewController.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/23/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit

class AddNewScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var schedules = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            if let groups = BSUIRSchedule.getGroups() {
                self.schedules = groups.sorted()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewScheduleTableViewCell") as! AddNewScheduleTableViewCell
        let title = schedules[indexPath.row]
        
        cell.title.text = title
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let destinationNavigationController = segue.destination as! UINavigationController
        let subgroupSelectionViewController = destinationNavigationController.topViewController as! SubgroupSelectionViewController
        
//        guard let subgroupSelectionViewController = segue.destination as? SubgroupSelectionViewController else {
//            fatalError("Unexpected destination: \(segue.destination)")
//        }
        
        guard let addNewScheduleTableViewCell = sender as? AddNewScheduleTableViewCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        guard let indexPath = tableView.indexPath(for: addNewScheduleTableViewCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedGroup = schedules[indexPath.row]
        subgroupSelectionViewController.group = selectedGroup
    }

}
