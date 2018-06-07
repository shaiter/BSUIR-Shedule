//
//  SettingsTableViewCell.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/22/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit

class StudentsSettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subgroup: UISegmentedControl!
    
    var studentsSchedule: StudentsSchedule?
    {
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI() {
        self.title.text = studentsSchedule?.title
        if studentsSchedule?.subgroup == StudentsSchedule.Subgroup.first {
            self.subgroup.selectedSegmentIndex = 0
        } else {
            self.subgroup.selectedSegmentIndex = 1
        }
    }
}
