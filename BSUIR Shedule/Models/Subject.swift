//
//  Subject.swift
//  BSUIR Schedule
//
//  Created by Артём Шайтер on 3/25/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit

class Subject {
    var title: String
    var auditory: String
    var time: String
    var employee: String
    var photo: UIImage = #imageLiteral(resourceName: "kon'")
    var weekNumber : [Int]
    var subgroup: Int
    
    
    
    init(title: String, auditory: String, time: String, employee: String, weekNumber: [Int], subgroup: Int) {
        self.title = title
        self.auditory = auditory
        self.time = time
        self.employee = employee
        self.weekNumber = weekNumber
        self.subgroup = subgroup
    }
}
