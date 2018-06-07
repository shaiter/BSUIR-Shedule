//
//  File.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/15/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import Foundation
import UIKit
import os.log

class BSUIRSchedule {
    
    static let lessonTimes = ["08:00 - 09:35",
                              "09:45 - 11:20",
                              "11:40 - 13:15",
                              "13:25 - 15:00",
                              "15:20 - 16:55",
                              "17:05 - 18:40",
                              "18:45 - 20:20",
                              "20:25 - 22:00"]
    
    static let weekDays = ["Понедельник",
                           "Вторник",
                           "Среда",
                           "Четверг",
                           "Пятница",
                           "Суббота",]
    
    
    static var studentsSchedules = [StudentsSchedule]()
    static var teachers = [Teacher]()
    static var selectedGroup = ""
    static var isNeedToReloadTitle = true
    
    private static let teachersDocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    private static let teachersArchiveURL = teachersDocumentsDirectory.appendingPathComponent("teachers")
    private static let schedulesDocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    private static let schedulesArchiveURL = schedulesDocumentsDirectory.appendingPathComponent("schedules")
    private static let selectedGroupDocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    private static let selectedGroupArchiveURL = schedulesDocumentsDirectory.appendingPathComponent("selectedGroup")
    
    static func saveData() {
        saveTeachers()
        saveSchedules()
        saveSelectedGroup()
    }
    
    static func saveSelectedGroup() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(selectedGroup, toFile: selectedGroupArchiveURL.path)
        if isSuccessfulSave {
            os_log("saveSelectedGroup successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save saveSelectedGroup...", log: OSLog.default, type: .error)
        }
    }
    
    private static func saveTeachers() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(teachers, toFile: teachersArchiveURL.path)
        if isSuccessfulSave {
            os_log("Teachers successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save teachers...", log: OSLog.default, type: .error)
        }
    }
    
    private static func saveSchedules() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(studentsSchedules, toFile: schedulesArchiveURL.path)
        if isSuccessfulSave {
            os_log("Schedules successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save schedules...", log: OSLog.default, type: .error)
        }
    }
    
    static func loadData() {
        if let teachers = NSKeyedUnarchiver.unarchiveObject(withFile: teachersArchiveURL.path) as? [Teacher] {
            self.teachers = teachers
        }
        if let studentsSchedules = NSKeyedUnarchiver.unarchiveObject(withFile: schedulesArchiveURL.path) as? [StudentsSchedule] {
            self.studentsSchedules = studentsSchedules
        }
        if let selectedGroup = NSKeyedUnarchiver.unarchiveObject(withFile: selectedGroupArchiveURL.path) as? String {
            self.selectedGroup = selectedGroup
        }
    }
    
    
    
    
    
    static func getStudentsSchedule(numGroup: String, subgroup: StudentsSchedule.Subgroup) -> StudentsSchedule? {
        let scheduleURL: URL = URL(string: "https://students.bsuir.by/api/v1/studentGroup/schedule?studentGroup=\(numGroup)")!
        let studentsSchedule = StudentsSchedule(title: numGroup, schedule: [], subgroup: subgroup)
        if let data = try? Data(contentsOf: scheduleURL){
            do {
                let groups = try JSONDecoder().decode(List.self, from: data)
                if let schedules = groups.schedules{
                    for schedule in schedules {
                        if let weekDay = schedule.weekDay {
                            studentsSchedule.schedule.append(Weekday(title: weekDay, subjects: []))
                            if let subjects = schedule.schedule {
                                for subject in subjects{
                                    let title = subject.subject ?? ""
                                    var auditory = ""
                                    if let auditorys = subject.auditory{
                                        if auditorys.count > 1{
                                            auditory = auditorys[0]
                                        }
                                    }
                                    var time = subject.startLessonTime ?? ""
                                    time += " "
                                    time += subject.endLessonTime ?? ""
                                    
                                    var weekNumber = [Int]()
                                    if let weekNumbers = subject.weekNumber{
                                        weekNumber = weekNumbers
                                        if weekNumber[0] == 0 {
                                            weekNumber.remove(at: 0)
                                        }
                                    }
                                    let subgroup = subject.numSubgroup ?? 0
                                    var teachers = [Teacher]()
                                    if let employeeArr = subject.employee{
                                        
                                        for teacher in employeeArr {
                                            var fio = teacher.lastName ?? ""
                                            fio += " "
                                            fio += teacher.firstName ?? ""
                                            fio += " "
                                            fio += teacher.middleName ?? ""
                                            let photoLink = teacher.photoLink
                                            var photo = #imageLiteral(resourceName: "user")
                                            if let photoLink = photoLink {
                                                photo = self.getPhoto(path: photoLink) ?? #imageLiteral(resourceName: "user")
                                            }
                                            if let id = teacher.id {
                                                let newTeacher = Teacher(id: id, fio: fio, photo: photo)
                                                var existingteacher = self.teachers.filter(){$0.id == id}
                                                if existingteacher.isEmpty {
                                                    teachers.append(newTeacher)
                                                    self.teachers.append(newTeacher)
                                                } else {
                                                    teachers.append(existingteacher[0])
                                                }
                                            }
                                            
                                        }
                                    }
                                    let subjectType = subject.lessonType ?? "ПЗ"
                                    studentsSchedule.schedule[studentsSchedule.schedule.count - 1].subjects.append(Subject(title: title, auditory: auditory, time: time, teachers: teachers, weekNumber: weekNumber, subgroup: subgroup, subjectType: subjectType))
                                }
                            }
                        }
                    }
                    return studentsSchedule
                } else {
                    return nil
                }
            } catch (let err) {
                print("\(errno): \(err)")
                return nil
            }
        } else {
            return nil
        }
        
    }
    
    static func getPhoto(path: String) -> UIImage? {
        let photoURL: URL = URL(string: path)!
        if let data = try? Data(contentsOf: photoURL){
            let photo = UIImage(data: data)
            return photo
        } else {
            return nil
        }
    }
    
    
    
    static func getGroups() -> [String]? {
        var schedules = [String]()
        
        let scheduleURL: URL = URL(string: "https://students.bsuir.by/api/v1/groups")!
        
        if let data = try? Data(contentsOf: scheduleURL){
            
            do {
                let groups = try JSONDecoder().decode([StudentGroup].self, from: data)
                for schedule in groups {
                    if let name = schedule.name {
                        schedules.append(name)
                    }
                }
                return schedules
            } catch (let err) {
                print("\(errno): \(err)")
                return nil
            }
        } else {
            return nil
        }
        
    }
    
    static private var ids = [Int]()
    
    static func getNewTeacherId() -> Int {
        
        var id = 0
        
        repeat {
            id = Int(arc4random() % 50000)
        } while ids.contains(id)
        
        return id
    }
    
    private init() {}
        
}
