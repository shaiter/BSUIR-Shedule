//
//  File.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/15/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import Foundation

class BSUIRScheduleData {
    
    static let lessonTimes = ["08:00 - 09:35",
                              "09:45 - 11:20",
                              "11:40 - 13:15",
                              "13:25 - 15:00",
                              "15:20 - 16:55",
                              "17:05 - 18:40",
                              "18:45 - 20:20",
                              "20:25 - 22:00"]
    
    
    
    
    
    
    
    
    
//    func getData() {
//        let urlString = "https://students.bsuir.by/api/v1/studentGroup/schedule?studentGroup=651005"
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//            guard error == nil else { return }
//            do {
//                let groups = try JSONDecoder().decode(List.self, from: data)
//                if let schedules = groups.schedules{
//                    for i in schedules {
//                        if let schedule = i.schedule {
//                            for schedule in schedule {
//                                self.subjects.append(Subject(subject: schedule.subject, auditory: schedule.auditory))
//                            }
//                        }
//                    }
//                }
//                print(groups)
//            } catch let error {
//                print(error)
//            }
//            }.resume()
//    }
    
}
