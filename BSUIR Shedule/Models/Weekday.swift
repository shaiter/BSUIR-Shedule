//
//  Weekday.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/16/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import Foundation

class Weekday: NSObject, NSCoding {
    
    var title: String
    var titleIndex: Int
    var subjects: [Subject]
    
    private struct PropertyKey {
        static let title = "title"
        static let subjects = "subjects"
    }
    
    init(title: String, subjects: [Subject]) {
        switch title {
            case "Понедельник": titleIndex = 0
            case "Вторник": titleIndex = 1
            case "Среда": titleIndex = 2
            case "Четверг": titleIndex = 3
            case "Пятница": titleIndex = 4
            case "Суббота": titleIndex = 5
            default: titleIndex = -1
        }
        self.title = title
        self.subjects = subjects
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(subjects, forKey: PropertyKey.subjects)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: PropertyKey.title) as! String
        let subjects = aDecoder.decodeObject(forKey: PropertyKey.subjects) as! [Subject]
        self.init(title: title, subjects: subjects)
    }
}
