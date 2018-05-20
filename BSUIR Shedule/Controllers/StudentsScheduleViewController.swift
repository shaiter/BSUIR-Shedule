//
//  StudentsScheduleViewController.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/20/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit

class StudentsScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    var testSchedule = [Weekday]()
    
    var schedule = [Schedule]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //        testSchedule.append(Weekday(title: "Понедельник", subjects: [Subject(title: "ОСиСП", auditory: ["210-4"], time: "08:00 - 09:35", employee: "" ), Subject(title: "ОСиСП", auditory: ["210-4"], time: "09:45 - 11:20", employee: "" ), Subject(title: "ОСиСП", auditory: ["210-4"], time: "11:40 - 13:15", employee: "")]))
        //        testSchedule.append(Weekday(title: "Вторник", subjects: [Subject(title: "ОСиСП", auditory: ["210-4"], time: "08:00 - 09:35", employee: "" ), Subject(title: "ОСиСП", auditory: ["210-4"], time: "09:45 - 11:20", employee: "" ), Subject(title: "ОСиСП", auditory: ["210-4"], time: "11:40 - 13:15", employee: "" )]))
        //        testSchedule.append(Weekday(title: "Среда", subjects: [Subject(title: "ОСиСП", auditory: ["210-4"], time: "08:00 - 09:35", employee: "" ), Subject(title: "ОСиСП", auditory: ["210-4"], time: "09:45 - 11:20", employee: "" ), Subject(title: "ОСиСП", auditory: ["210-4"], time: "11:40 - 13:15", employee: "" )]))
        //        testSchedule.append(Weekday(title: "Четверг", subjects: [Subject(title: "ОСиСП", auditory: ["210-4"], time: "08:00 - 09:35", employee: "" ), Subject(title: "ОСиСП", auditory: ["210-4"], time: "09:45 - 11:20", employee: "" ), Subject(title: "ОСиСП", auditory: ["210-4"], time: "11:40 - 13:15", employee: "" )]))
        //        testSchedule.append(Weekday(title: "Пятница", subjects: [Subject(title: "ОСиСП", auditory: ["210-4"], time: "08:00 - 09:35", employee: "" ), Subject(title: "ОСиСП", auditory: ["210-4"], time: "09:45 - 11:20", employee: "" ), Subject(title: "ОСиСП", auditory: ["210-4"], time: "11:40 - 13:15", employee: "" )]))
        //        testSchedule.append(Weekday(title: "Суббота", subjects: [Subject(title: "ОСиСП", auditory: ["210-4"], time: "08:00 - 09:35", employee: "" ), Subject(title: "ОСиСП", auditory: ["210-4"], time: "09:45 - 11:20", employee: "" ), Subject(title: "ОСиСП", auditory: ["210-4"], time: "11:40 - 13:15", employee: "" )]))
        //
        
        
        
        
        
        
        
        
        
        let urlString = "https://students.bsuir.by/api/v1/studentGroup/schedule?studentGroup=651005"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                let groups = try JSONDecoder().decode(List.self, from: data)
                if let schedules = groups.schedules{
                    for schedule in schedules{
                        self.schedule.append(schedule)
                    }
                    
                    
                    self.testSchedule = []
                    
                    
                    for weekday in self.schedule {
                        self.testSchedule.append(Weekday(title: weekday.weekDay ?? "", subjects: []))
                        for subject in weekday.schedule! {
                            
                            var auditory = ""
                            if let auditoryArr = subject.auditory{
                                for newAuditory in auditoryArr {
                                    auditory += newAuditory
                                }
                            }
                            
                            var employee = ""
                            if let employeeArr = subject.employee{
                                for newEmployee in employeeArr {
                                    employee += newEmployee.fio ?? ""
                                }
                            }
                            
                            
                            var time = subject.startLessonTime ?? ""
                            time += " "
                            time += subject.endLessonTime ?? ""
                            
                            
                            self.testSchedule[self.testSchedule.count - 1].subjects.append(Subject(title: subject.subject ?? "", auditory: auditory, time: time, employee: employee, weekNumber: subject.weekNumber ?? [], subgroup: subject.numSubgroup ?? 0))
                            
                            
                            
                        }
                    }
                    
                    self.updateUI()
                    
                    
                }
                print(groups)
            } catch let error {
                print(error)
            }
            }.resume()
        
        
        //        for i in 0...1000000000{
        //            print(i)
        //        }
        
        
        
        
        
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return testSchedule.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testSchedule[section].subjects.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return testSchedule[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentsSchaduleTableViewCell") as! StudentsSchaduleTableViewCell
        let subject = testSchedule[indexPath.section].subjects[indexPath.row]
        
        cell.subject = subject
        
        return cell
    }

}
