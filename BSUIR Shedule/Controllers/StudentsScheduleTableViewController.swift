//
//  ViewController.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 4/11/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit

class StudentsScheduleTableViewController: UITableViewController {
    
    var schedule = [Weekday]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        schedule.append(Weekday(title: "Понедельник", subjects: [Subject(title: "ОСиСП", auditory: ["210-4"], time: "08:00 - 09:35", employee: nil, photoURL: nil), Subject(title: "ОСиСП", auditory: ["210-4"], time: "09:45 - 11:20", employee: nil, photoURL: nil), Subject(title: "ОСиСП", auditory: ["210-4"], time: "11:40 - 13:15", employee: nil, photoURL: nil)]))
        schedule.append(Weekday(title: "Вторник", subjects: [Subject(title: "ОСиСП", auditory: ["210-4"], time: "08:00 - 09:35", employee: nil, photoURL: nil), Subject(title: "ОСиСП", auditory: ["210-4"], time: "09:45 - 11:20", employee: nil, photoURL: nil), Subject(title: "ОСиСП", auditory: ["210-4"], time: "11:40 - 13:15", employee: nil, photoURL: nil)]))
        schedule.append(Weekday(title: "Среда", subjects: [Subject(title: "ОСиСП", auditory: ["210-4"], time: "08:00 - 09:35", employee: nil, photoURL: nil), Subject(title: "ОСиСП", auditory: ["210-4"], time: "09:45 - 11:20", employee: nil, photoURL: nil), Subject(title: "ОСиСП", auditory: ["210-4"], time: "11:40 - 13:15", employee: nil, photoURL: nil)]))
        schedule.append(Weekday(title: "Четверг", subjects: [Subject(title: "ОСиСП", auditory: ["210-4"], time: "08:00 - 09:35", employee: nil, photoURL: nil), Subject(title: "ОСиСП", auditory: ["210-4"], time: "09:45 - 11:20", employee: nil, photoURL: nil), Subject(title: "ОСиСП", auditory: ["210-4"], time: "11:40 - 13:15", employee: nil, photoURL: nil)]))
        schedule.append(Weekday(title: "Пятница", subjects: [Subject(title: "ОСиСП", auditory: ["210-4"], time: "08:00 - 09:35", employee: nil, photoURL: nil), Subject(title: "ОСиСП", auditory: ["210-4"], time: "09:45 - 11:20", employee: nil, photoURL: nil), Subject(title: "ОСиСП", auditory: ["210-4"], time: "11:40 - 13:15", employee: nil, photoURL: nil)]))
        schedule.append(Weekday(title: "Суббота", subjects: [Subject(title: "ОСиСП", auditory: ["210-4"], time: "08:00 - 09:35", employee: nil, photoURL: nil), Subject(title: "ОСиСП", auditory: ["210-4"], time: "09:45 - 11:20", employee: nil, photoURL: nil), Subject(title: "ОСиСП", auditory: ["210-4"], time: "11:40 - 13:15", employee: nil, photoURL: nil)]))
        
        
        
        
        
                    let urlString = "https://students.bsuir.by/api/v1/studentGroup/schedule?studentGroup=651005"
                    guard let url = URL(string: urlString) else { return }
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        guard let data = data else { return }
                        guard error == nil else { return }
                        do {
                            let groups = try JSONDecoder().decode(List.self, from: data)
                            if let schedules = groups.schedules{
                                
                                
                            }
                            print(groups)
                        } catch let error {
                            print(error)
                        }
                        }.resume()
        
    
        
        
        
        
        
        
        
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return schedule.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule[section].subjects.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return schedule[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentsSchaduleTableViewCell") as! StudentsSchaduleTableViewCell
        let subject = schedule[indexPath.section].subjects[indexPath.row]
        
        cell.subject = subject
        
        return cell
    }

}








