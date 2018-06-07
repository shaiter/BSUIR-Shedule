//
//  StudentsScheduleViewController.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/20/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit
import Dropdowns

class StudentsScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNewSubject: UIBarButtonItem!
    
    var schedule: StudentsSchedule?
    
    let selectGroupButton =  UIButton(type: .custom)
    
    var titleView: TitleView?
    
    
    override func viewDidAppear(_ animated: Bool) {
        if BSUIRSchedule.studentsSchedules.isEmpty {
            addNewSubject.isEnabled = false
            tableView.isHidden = true
        } else if BSUIRSchedule.isNeedToReloadTitle {
            addNewSubject.isEnabled = true
            tableView.isHidden = false
            let schedule = BSUIRSchedule.studentsSchedules.filter{$0.title == BSUIRSchedule.selectedGroup}
            
            self.schedule = schedule[0]
            setupTitle()
            BSUIRSchedule.isNeedToReloadTitle = false
            print("title reloaded")
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BSUIRSchedule.loadData()
        
    }
    
    func updateTitle() {
        var items = [String]()
        for schedules in BSUIRSchedule.studentsSchedules {
            items.append(schedules.title)
        }
        let initialIndex = items.index(of: BSUIRSchedule.selectedGroup) ?? 0
        let contentController = TableController(items: items, initialIndex: initialIndex)
        let dropdown = DropdownController(contentController: contentController, navigationController: navigationController!)
        titleView?.dropdown = dropdown
    }
    
    func setupTitle() {
        Config.List.DefaultCell.separatorColor = UIColor.gray
        Config.List.backgroundColor = UIColor.gray
        Config.topLineColor = UIColor.gray
        Config.ArrowButton.Text.color = UIColor.white
        var items = [String]()
        for schedules in BSUIRSchedule.studentsSchedules {
            items.append(schedules.title)
        }
        titleView = TitleView(navigationController: navigationController!, title: BSUIRSchedule.selectedGroup, items: items)
        titleView?.action = { [weak self] index in
            print("select \(index)")
            
            self?.schedule = BSUIRSchedule.studentsSchedules[index]
            BSUIRSchedule.selectedGroup = (self?.schedule?.title)!
            BSUIRSchedule.saveSelectedGroup()
            self?.tableView.reloadData()
        }
        navigationItem.titleView = titleView
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return schedule?.schedule.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule?.schedule[section].subjects.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return schedule?.schedule[section].title ?? ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentsSchaduleTableViewCell") as! StudentsSchaduleTableViewCell
        let subject = schedule?.schedule[indexPath.section].subjects[indexPath.row]
        cell.subject = subject
        return cell
    }
    
    @IBAction func unwindToSchedule(sender: UIStoryboardSegue) {
        print("hui")
        if let sourceViewController = sender.source as? DetaleStudentsScheduleTableViewController, let weekdaySubject = sourceViewController.weekdaySubject {
            let queue = DispatchQueue.global(qos: .userInitiated)
            queue.async {
                var filteredSchedule = self.schedule?.schedule.filter{ $0.title == weekdaySubject.title}
                if (filteredSchedule?.isEmpty)! {
                    self.schedule?.schedule.append(weekdaySubject)
                    self.schedule?.schedule.sort(by: { $0.titleIndex < $1.titleIndex })
                } else {
                    filteredSchedule?[0].subjects.append(weekdaySubject.subjects[0])
                    if filteredSchedule![0].subjects.count > 2 {
                        filteredSchedule![0].subjects.sort(by: { $0.timeIndex < $1.timeIndex })
                    }
                }
                BSUIRSchedule.saveData()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

}
