//
//  StudentsSchedule.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/23/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import Foundation

class StudentsSchedule: NSObject, NSCoding {
    
    var title: String
    
    enum Subgroup: Int {
        case first
        case second
    }
    
    
    var subgroup: Subgroup
    var schedule = [Weekday]()
    
    private struct PropertyKey {
        static let title = "title"
        static let subgroup = "subgroup"
        static let schedule = "schedule"
    }
    
    init(title: String, schedule: [Weekday], subgroup: Subgroup) {
        self.title = title
        self.schedule = schedule
        self.subgroup = subgroup
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(subgroup.hashValue, forKey: PropertyKey.subgroup)
        aCoder.encode(schedule, forKey: PropertyKey.schedule)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: PropertyKey.title) as! String
        let subgroup = StudentsSchedule.Subgroup(rawValue: aDecoder.decodeInteger(forKey: PropertyKey.subgroup))!
        let schedule = aDecoder.decodeObject(forKey: PropertyKey.schedule) as! [Weekday]
        self.init(title: title, schedule: schedule, subgroup: subgroup)
    }
    
}
