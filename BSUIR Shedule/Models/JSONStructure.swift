//
//  JSONStructure.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/15/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import Foundation

struct List: Decodable {
    var employee: Employee?
    var studentGroup: StudentGroup?
    var schedules: [Schedule]?
    var examSchedules: [Schedule]?
    var todayDate: String?
    var todaySchedules: [Schedule]?
    var tomorrowDate: String?
    var tomorrowSchedules: [Schedule]?
    var currentWeekNumber: Int?
}


struct Schedule: Decodable{
    var weekDay: String?
    var schedule: [Class]?
    
}

struct Class: Decodable{
    var weekNumber: [Int]?
    var studentGroup: [String]?
    var numSubgroup: Int?
    var auditory: [String]?
    var lessonTime: String?
    var startLessonTime: String?
    var endLessonTime: String?
    var subject: String?
    var note: String?
    var lessonType: String?
    var employee: [Employee]?
    var zaoch: Bool?
}

struct Employee: Decodable{
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var rank: String?
    var photoLink: String?
    var calendarId: String?
    var academicDepartment: [String]?
    var id: Int?
    var fio: String?
}



struct StudentGroup: Decodable {
    var name: String?
    var facultyId: Int?
    var specialityDepartmentEducationFormId: Int?
    var course: Int?
    var id: Int?
    var calendarId: String?
}
