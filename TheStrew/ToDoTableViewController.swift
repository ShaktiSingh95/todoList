//
//  ToDoTableViewController.swift
//  TheStrew
//
//  Created by Shakti Pratap Singh on 11/07/17.
//  Copyright © 2017 Shakti Pratap Singh. All rights reserved.
//

import UIKit
import RealmSwift
class ToDoTableViewController: UITableViewController {
    var tasks:[Task] = [Task](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var realm : Realm!
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        let addBarButton = UIBarButtonItem(title: "ADD", style: .plain, target: self, action: #selector(ToDoTableViewController.addNewToDo))
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    func addNewToDo(){
        let task = Task()
        task.title="ads"
        task.date=Date(timeIntervalSince1970: 23212131231)
        task.priority=9
        tasks.append(task)
        do {
            try realm.write {
                realm.add(task)
            }
        } catch {
        }
    }
    func fetchData(){
        tasks = Array(realm.objects(Task.self))
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo_cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].title
        cell.detailTextLabel?.text="\(tasks[indexPath.row].date)"+"\(tasks[indexPath.row].priority)"
        return cell
    }
    
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
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
            let destinationVc = self.storyboard?.instantiateViewController(withIdentifier: "sort_vc") as! SortViewController
            destinationVc.modalPresentationStyle = .overCurrentContext
            //self.navigationController?.pushViewController(destinationVc, animated: true)
            self.present(destinationVc, animated: true, completion: nil)
})
        return [delete,edit]
    }
     // Override to support editing the table view.
//     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//     if editingStyle == .delete {
//        do{
//           try realm.write {
//            realm.delete(tasks[indexPath.row])
//            }
//        }catch{
//            
//        }
//        fetchData()
//     } else if editingStyle == .insert {
//     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//     }
//     }
//    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
