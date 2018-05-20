//
//  Weekday.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/16/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import Foundation

class Weekday {
    
    var title: String
    var subjects: [Subject]
    
    init(title: String, subjects: [Subject]) {
        self.title = title
        self.subjects = subjects
    }
}
