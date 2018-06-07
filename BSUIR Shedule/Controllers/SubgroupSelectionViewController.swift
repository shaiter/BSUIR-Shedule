//
//  SubgroupSelectionViewController.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/26/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit

class SubgroupSelectionViewController: UIViewController {
    
    @IBOutlet weak var subgroupSegmentedControl: UISegmentedControl!
    
    var group: String?
    var subGroup: StudentsSchedule.Subgroup?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = group
        subGroup = StudentsSchedule.Subgroup(rawValue: subgroupSegmentedControl.selectedSegmentIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func selectSubgroup(_ sender: UISegmentedControl) {
        subGroup = StudentsSchedule.Subgroup(rawValue: subgroupSegmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
