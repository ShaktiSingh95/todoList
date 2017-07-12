//
//  SortViewController.swift
//  TheStrew
//
//  Created by Shakti Pratap Singh on 11/07/17.
//  Copyright © 2017 Shakti Pratap Singh. All rights reserved.
//

import UIKit

class SortViewController: UIViewController {
    var delegate:ToDoTableViewController!
    var sortOrder:Order!
    var sortBy : String!
    @IBOutlet weak var subView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subView.clipsToBounds = true
        subView.layer.cornerRadius = 15
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
    }
    @IBAction func sortByDate(_ sender: UIButton) {
        sortBy="date"
        self.switchState(sender)
        priority.isSelected=false
    }
    @IBAction func ascendingOrder(_ sender: UIButton) {
        sortOrder = Order.ascending
        self.switchState(sender)
        descend.isSelected=false
    }
    @IBAction func descendingOrder(_ sender: UIButton) {
        sortOrder = Order.descending
        self.switchState(sender)
        ascend.isSelected=false
    }
    @IBAction func sortByPriority(_ sender: UIButton) {
        sortBy = "priority"
        self.switchState(sender)
        date.isSelected=false
    }
    @IBOutlet weak var descend: UIButton!
    @IBOutlet weak var ascend: UIButton!
    @IBOutlet weak var date: UIButton!
    @IBOutlet weak var priority: UIButton!
    @IBAction func go(_ sender: UIButton) {
        if(sortBy != nil && sortOrder != nil){
            delegate.sortTasks(by: sortBy, order: sortOrder)
            self.dismiss(animated: true, completion: nil)
        }
        else{
            
        }
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func switchState(_ sender : UIButton){
        sender.isSelected = !sender.isSelected
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

enum Order{
    case ascending
    case descending
}
