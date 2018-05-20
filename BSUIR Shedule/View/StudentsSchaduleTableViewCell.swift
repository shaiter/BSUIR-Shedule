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
        self.photo.image = subject?.photo
        if subject?.weekNumber[0] == 0 {
            self.weekNumber.text = "1,2,3,4"
        } else {
            var weeks = ""
            for weekNumber in (subject?.weekNumber)! {
                weeks += String(weekNumber)
            }
            self.weekNumber.text = weeks
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
