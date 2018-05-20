//
//  DetaleStudentsScheduleTableViewController.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/19/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit

class DetaleStudentsScheduleTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var employeePhoto: UIImageView!
    @IBOutlet weak var employeeFIO: UITextField!
    @IBOutlet weak var subjectTitle: UITextField!
    @IBOutlet weak var lessonTime: UITextField!
    @IBOutlet weak var lessonType: UISegmentedControl!
    @IBOutlet var numSubgroup: [UISwitch]!
    @IBOutlet var weekNumber: [UISwitch]!
    @IBOutlet weak var auditory: UITextField!
    
    var subject: Subject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTimePicker()
        createTimePickerToolbar()
         
        employeePhoto.layer.cornerRadius = UIScreen.main.bounds.width / 2
        employeePhoto.layer.masksToBounds = true
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
    }
    
    func createTimePickerToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DetaleStudentsScheduleTableViewController.dismissKeyboard))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        lessonTime.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BSUIRScheduleData.lessonTimes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return BSUIRScheduleData.lessonTimes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lessonTime.text = BSUIRScheduleData.lessonTimes[row]
    }
    
    
}


extension DetaleStudentsScheduleTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension DetaleStudentsScheduleTableViewController {
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        employeeFIO.resignFirstResponder()
        subjectTitle.resignFirstResponder()
        lessonTime.resignFirstResponder()
        auditory.resignFirstResponder()
    }
}















