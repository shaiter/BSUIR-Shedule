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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photo.layer.cornerRadius = 27
        photo.layer.masksToBounds = true
    }
    
    var subject: Subject? {
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI() {
        self.title?.text = subject!.title
        self.auditory?.text = subject?.auditory![0]
        self.lessonTime?.text = subject!.time
        self.photo?.image = subject?.photo
    }
    

}
