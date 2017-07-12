//
//  ToDoTableViewController.swift
//  TheStrew
//
//  Created by Shakti Pratap Singh on 11/07/17.
//  Copyright © 2017 Shakti Pratap Singh. All rights reserved.
//

import UIKit
import RealmSwift
class ToDoTableViewController: UITableViewController,UISearchBarDelegate {
    var tasks:[Task] = [Task](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var shouldShowSearchResults=false
    var filteredResult = [Task]()
    var realm : Realm!
    let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        let addBarButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.presentAddTaskFunctionality))
        let sortBarButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(self.presentSortFunctionality))
        self.navigationItem.rightBarButtonItems = [addBarButton,sortBarButton]
        searchBar.showsCancelButton=false
        searchBar.placeholder="search task"
        searchBar.delegate=self
        self.navigationItem.titleView=searchBar
    }
    
    func presentAddTaskFunctionality(){
        let destinationVc = self.storyboard?.instantiateViewController(withIdentifier: "add_task_vc") as! AddTaskViewController
        destinationVc.delegate=self
        self.navigationController?.pushViewController(destinationVc, animated: true)
    }
    
    func presentSortFunctionality(){
        let destinationVc = self.storyboard?.instantiateViewController(withIdentifier: "sort_vc") as! SortViewController
        destinationVc.modalPresentationStyle = .overCurrentContext
        destinationVc.delegate=self
        self.present(destinationVc, animated: true, completion: nil)
    }
    
    func addNewToDo(task:Task){
        tasks.append(task)
        do {
            try realm.write {
                realm.add(task)
            }
        } catch {
        }
    }
    
    func updateToDo(task:Task,priority:Int,title:String,date:Date){
        do {
            try realm.write {
                task.priority=priority
                task.date=date
                task.title=title
            }
        } catch {
        }

    }
    
    func fetchData(){
        tasks = Array(realm.objects(Task.self))
    }
    
    func sortTasks(by : String, order : Order){
        if by == "date"{
            if order == .descending{
                tasks.sort{$0.date>$1.date}
            }
            else{
                tasks.sort{$0.date<$1.date}
            }
        }
        else if(by == "priority"){
            if order == .descending{
                tasks.sort{$0.priority>$1.priority}
            }
            else{
                tasks.sort{$0.priority<$1.priority}
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        shouldShowSearchResults=true
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredResult = tasks.filter({(tasks : Task) -> Bool in return (tasks.title.lowercased().range(of: searchText.lowercased()) != nil)})
        if searchText != ""{
            shouldShowSearchResults=true
            tableView.reloadData()
        }
        else{
            shouldShowSearchResults=false
            tableView.reloadData()
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults==true{
            return filteredResult.count
        }
        else{
            return tasks.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tasks:[Task]!
        if(shouldShowSearchResults==true){
            tasks=filteredResult
        }
        else{
            tasks=self.tasks
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo_cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].title
        print(dateFormatter.string(from:tasks[indexPath.row].date))
        print(tasks[indexPath.row].priority)
        cell.detailTextLabel?.text="deadline : \(dateFormatter.string(from:tasks[indexPath.row].date))"+"  Priority : \(tasks[indexPath.row].priority)"
        return cell
    }
    
    
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     return true
     }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete", handler: {(rowAction,indexPath) in
            do{
                try self.realm.write {
                    self.realm.delete(self.tasks[indexPath.row])
                }
            }catch{
                
            }
            self.fetchData()
        })
        let edit = UITableViewRowAction(style: .destructive, title: "Edit", handler: {
            (rowAction,indexPath) in
            let destinationVc = self.storyboard?.instantiateViewController(withIdentifier: "add_task_vc") as! AddTaskViewController
            destinationVc.task=self.tasks[indexPath.row]
            destinationVc.delegate=self
            self.navigationController?.pushViewController(destinationVc, animated: true)
})
        return [delete,edit]
    }
}
