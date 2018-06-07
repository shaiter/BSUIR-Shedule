//
//  DetaleStudentsScheduleTableViewController.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/19/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit
import os.log

class DetaleStudentsScheduleTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var employeePhoto: UIImageView!
    @IBOutlet weak var employeeFIO: UITextField!
    @IBOutlet weak var subjectTitle: UITextField!
    @IBOutlet weak var weekday: UITextField!
    @IBOutlet weak var lessonTime: UITextField!
    @IBOutlet weak var lessonTypeSegmentedControl: UISegmentedControl!
    @IBOutlet var numSubgroup: [UISwitch]!
    @IBOutlet var weekNumber: [UISwitch]!
    @IBOutlet weak var auditory: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func `switch`(_ sender: UISwitch) {
        updateSaveButtonState()
    }
    
    
    var weekdaySubject: Weekday?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTimePicker()
        createTimePickerToolbar()
         
        employeePhoto.layer.cornerRadius = UIScreen.main.bounds.width / 2
        employeePhoto.layer.masksToBounds = true
        
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let title = subjectTitle.text!
        let auditory = self.auditory.text ?? ""
        
        let firstiIndex = lessonTime.text!.index(lessonTime.text!.startIndex, offsetBy: 5)
        let secondiIndex = lessonTime.text!.index(lessonTime.text!.startIndex, offsetBy: 7)
        let time = String(lessonTime.text![..<firstiIndex]) + String(lessonTime.text![secondiIndex..<lessonTime.text!.endIndex])
        var weekNumber = [Int]()
        
        for weeknum in 0..<self.weekNumber.count {
            if self.weekNumber[weeknum].isOn{
                weekNumber.append(weeknum)
            }
        }
        
        var subgroup = 0
        if !numSubgroup[0].isOn {
            subgroup = 2
        } else if !numSubgroup[1].isOn {
            subgroup = 1
        }
        var teachers = [Teacher]()
        let existingTeacher = BSUIRSchedule.teachers.filter{$0.fio == employeeFIO.text!}
        if existingTeacher.isEmpty {
            let id = BSUIRSchedule.getNewTeacherId()
            let newTeacher = Teacher(id: id, fio: employeeFIO.text!, photo: employeePhoto.image!)
            teachers.append(newTeacher)
            BSUIRSchedule.teachers.append(newTeacher)
        } else {
            teachers.append(existingTeacher[0])
        }
        var lessonType = ""
        switch lessonTypeSegmentedControl.selectedSegmentIndex {
        case 0: lessonType = "ЛК"
        case 1: lessonType = "ПЗ"
        case 2: lessonType = "ЛР"
        default: lessonType = "ПЗ"
        }
        
        let subject = Subject(title: title, auditory: auditory, time: time, teachers: teachers, weekNumber: weekNumber, subgroup: subgroup, subjectType: lessonType)
        weekdaySubject = Weekday(title: weekday.text!, subjects: [subject])
    }
    
    // MARK: - UITableView
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 && indexPath.row == 0 {
            pickImage()
            return nil
        } else {
            return nil
        }
    }
    
    private func updateSaveButtonState() {
        let employeeFIO = self.employeeFIO.text ?? ""
        let subjectTitle = self.subjectTitle.text ?? ""
        let lessonTime = self.lessonTime.text ?? ""
        let weekday = self.weekday.text ?? ""
        var isNumSubgroupSelected = true
        if !numSubgroup[0].isOn && !numSubgroup[1].isOn {
            isNumSubgroupSelected = false
        }
        var isWeekNumberSelected = true
        if !weekNumber[0].isOn && !weekNumber[1].isOn && !weekNumber[2].isOn && !weekNumber[3].isOn {
            isWeekNumberSelected = false
        }
        saveButton.isEnabled = !employeeFIO.isEmpty && !subjectTitle.isEmpty && !weekday.isEmpty && !lessonTime.isEmpty && isNumSubgroupSelected && isWeekNumberSelected
    }
    
    // MARK: - UIImagePicker
    
    func pickImage() {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){}
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            employeePhoto.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIPickerView
    
    func createTimePicker() {
        let timePicker = UIPickerView()
        timePicker.delegate = self
        timePicker.backgroundColor = .white
        lessonTime.inputView = timePicker
        weekday.inputView = timePicker
    }
    
    func createTimePickerToolbar() {
        let lessonTimeToolbar = UIToolbar()
        lessonTimeToolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DetaleStudentsScheduleTableViewController.dismissKeyboard))
        lessonTimeToolbar.setItems([spaceButton, doneButton], animated: false)
        lessonTimeToolbar.isUserInteractionEnabled = true
        
        lessonTimeToolbar.tag = 0
        lessonTime.inputAccessoryView = lessonTimeToolbar
        
        let weekdayToolbar = UIToolbar()
        weekdayToolbar.sizeToFit()
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DetaleStudentsScheduleTableViewController.dismissKeyboard))
        weekdayToolbar.setItems([spaceButton2, doneButton2], animated: false)
        weekdayToolbar.isUserInteractionEnabled = true
        
        weekdayToolbar.tag = 1
        weekday.inputAccessoryView = weekdayToolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        if lessonTime.isEditing {
            return BSUIRSchedule.lessonTimes.count
        } else {
            return BSUIRSchedule.weekDays.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if lessonTime.isEditing {
            return BSUIRSchedule.lessonTimes[row]
        } else {
            return BSUIRSchedule.weekDays[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if lessonTime.isEditing {
            lessonTime.text = BSUIRSchedule.lessonTimes[row]
        } else {
            weekday.text = BSUIRSchedule.weekDays[row]
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension DetaleStudentsScheduleTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateSaveButtonState()
        return true
    }
    
}

extension DetaleStudentsScheduleTableViewController {
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        employeeFIO.resignFirstResponder()
        subjectTitle.resignFirstResponder()
        lessonTime.resignFirstResponder()
        auditory.resignFirstResponder()
        weekday.resignFirstResponder()
        updateSaveButtonState()
    }
}














