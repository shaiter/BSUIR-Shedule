//
//  InsideStudentsSchaduleTableViewCell.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/15/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit

class StudentsSchaduleTableViewCell: UITableViewCell {

    @IBOutlet weak var lessonTime: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var auditory: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var weekNumber: UILabel!
    @IBOutlet weak var subgroup: UILabel!
    @IBOutlet weak var lessonType: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photo.layer.cornerRadius = 27
        photo.layer.masksToBounds = true
    }
    
    var subject: Subject?
        {
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI() {
        self.title.text = subject?.title
        self.auditory.text = subject?.auditory
        self.lessonTime.text = subject?.time
        if subject!.teachers.count > 0 {
            self.photo.image = subject?.teachers[0].photo
        } else {
            self.photo.isHidden = true
        }
        
        var weeks = ""
        for weekNumber in (subject?.weekNumber)! {
            weeks += String(weekNumber)
        }
        self.weekNumber.text = weeks
        switch subject?.subjectType {
        case "ЛК": lessonType.image = #imageLiteral(resourceName: "green")
        case "ПЗ": lessonType.image = #imageLiteral(resourceName: "yellow")
        case "ЛР": lessonType.image = #imageLiteral(resourceName: "red")
        default: lessonType.image = #imageLiteral(resourceName: "yellow")
        }
        if !(subject?.subgroup == 0) {
            if let subgroup = subject?.subgroup {
                self.subgroup.text = String(subgroup)
            }
        } else {
            self.subgroup.text = ""
        }
        
    }
    

}
