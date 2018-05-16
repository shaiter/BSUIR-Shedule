//
//  Subject.swift
//  BSUIR Schedule
//
//  Created by Артём Шайтер on 3/25/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit

class Subject: NSObject {
    var title: String?
    var auditory: [String]?
    var time: String?
    var employee: String?
    var photoURL: String?
    var photo: UIImage = #imageLiteral(resourceName: "kon'")
    
    
    init(title: String?, auditory: [String]?, time: String?, employee: String?, photoURL: String?) {
        self.title = title
        self.auditory = auditory
        self.time = time
        self.photoURL = photoURL
        self.employee = employee
        super.init()
    }
}
