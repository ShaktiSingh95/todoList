//
//  AddTaskViewController.swift
//  TheStrew
//
//  Created by Shakti Pratap Singh on 12/07/17.
//  Copyright © 2017 Shakti Pratap Singh. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    var dateAndTime=Date()
    var delegate:ToDoTableViewController!
    var task:Task?
    var editMode = false
    @IBOutlet weak var priorityTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTimePicker.datePickerMode = .dateAndTime
        if task != nil{
            editMode = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if editMode == true{
            priorityTextField.text=String(task!.priority)
            titleTextField.text=task!.title
            dateTimePicker.date=task!.date
            dateAndTime=task!.date
        }
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        setDateAndTime()
    }
    @IBAction func add(_ sender: UIButton) {
        if priorityTextField.text! != "" && titleTextField.text! != "", let _ = Int(priorityTextField.text!){
            var priority:Int
            if let a = Int(priorityTextField.text!){
                priority=a
            }
            else {
                priority=0
            }
            if editMode==true{
                delegate.updateToDo(task: task!, priority: priority, title: titleTextField.text!, date: dateAndTime)
            }
            let newTask = Task()
            newTask.date=dateAndTime
                newTask.priority=priority
            newTask.title=titleTextField.text!
            if editMode == false{
                delegate.addNewToDo(task: newTask)
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    func setDateAndTime() {
        dateAndTime = dateTimePicker.date
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
