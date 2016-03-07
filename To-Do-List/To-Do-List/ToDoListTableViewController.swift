//
//  ToDoListTableViewController.swift
//  To-Do-List
//
//  Created by Clark Chen on 2/20/16.
//  Copyright © 2016 ClarkChen. All rights reserved.
//

import UIKit


class ToDoListTableViewController: UITableViewController {
    
    var toDoItems: NSMutableArray = []
    var numCompletedTasks: Int = 0
    var clearTasks: Bool = false
    
    // check for removing 24 hour old completed tests in stats
    // if
    
    func loadInitialData(){ //load fake data


        
        var item1 = ToDoItem(name: "Buy milk")
        self.toDoItems.addObject(item1)
        
        var item2 = ToDoItem(name: "Buy eggs")
        self.toDoItems.addObject(item2)
        
        var item3 = ToDoItem(name: "Read a book")
        self.toDoItems.addObject(item3)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad!")
        loadInitialData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.toDoItems.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Configure the cell...
        
        print("incellforrow")
        let CellIndentifier: NSString = "ListPrototypeCell"
        
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIndentifier as String)! as UITableViewCell
        
        var todoitem: ToDoItem = self.toDoItems.objectAtIndex(indexPath.row) as! ToDoItem
        
        cell.textLabel!.text = todoitem.itemName as String
        
        if todoitem.completed{
            
            cell.accessoryType = .Checkmark
//            check24(todoitem)   MOVE THIS TO STATS.
            
            
        }
            
        else {
            
            cell.accessoryType = .None
            print("uncompleted a task!")
        }
        
        return cell
        
    }
    
    func getNumCompleted() -> Int {
        return numCompletedTasks
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath:
        
        NSIndexPath!) {
            
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            

            
            var tappedItem: ToDoItem = self.toDoItems.objectAtIndex(indexPath.row) as! ToDoItem
            
            if tappedItem.completed {
                numCompletedTasks -= 1
                tappedItem.completed = !tappedItem.completed

            } else {
                numCompletedTasks += 1
                tappedItem.completed = !tappedItem.completed
                tappedItem.creationDate = NSDate() //reset creationDate
            }
            

            print("completed a task!")
            //            print("total tasks completed" + String(ToDoListTableViewController.numCompletedTasks))
            
            tableView.reloadData()
            
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            //Delete from Array
            print("try to delete!!")
            toDoItems.removeObjectAtIndex(indexPath.row)
            self.tableView.reloadData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        
        //need reference to destination
        if segue.identifier == "statsPressed" {
            var destination: StatsViewController = segue.destinationViewController as! StatsViewController
            if self.clearTasks {
                self.numCompletedTasks = 0
                self.clearTasks = false //reset to false
            }
            destination.numCompleted = self.numCompletedTasks // set the num tasks of stats
        }

        
    }

    //return index in toDoItems of item to be removed; or if NOT REMOVING return NIL
    func check24(item :ToDoItem) -> Int? {
        print("incheck24")
        
        var curr = NSDate()
        var timeDif = curr.timeIntervalSinceDate(item.creationDate)
        print(timeDif)
        if timeDif > (86400) {
            // remove
            
            let index = toDoItems.indexOfObject(item)
            self.clearTasks = true

            return index
//            toDoItems.removeObjectAtIndex(index)
//            tableView.reloadData()
        }
        return nil
    }
    
    @IBAction func unwindToList(segue:UIStoryboardSegue){
        
        var indicesToRemove = [Int]()
        
        var numItems = self.toDoItems.count
        
        if self.toDoItems.count > 0 { //check for completed items and possibly remove
            for i in 0...(toDoItems.count - 1) {
                let item: ToDoItem = self.toDoItems.objectAtIndex(i) as! ToDoItem
                if item.completed {
                    if let x = check24(item) { // if check24 is nONNILL, NEED TO REMOVE
                        indicesToRemove.append(x)
                    }
                }
            }
        }

        
        while (indicesToRemove.count > 0) {
            self.toDoItems.removeObjectAtIndex(indicesToRemove.popLast()!)
        }
        
        tableView.reloadData()


        // Check that NOT UNWINDING FROM STATS
        if segue.identifier == "unwindStats" {
//            var source = segue.sourceViewController as! StatsViewController
            
            print("unwind from stats")
            print(toDoItems.count)
        } else {
            var source: AddToDoViewController = segue.sourceViewController as! AddToDoViewController
            //        if source == nil {
            //            print("source is nil")
            //        } apparently source "CAN'T" be nil
            print(source)
            if let item = source.toDoItem {
                self.toDoItems.addObject(item)
                self.tableView.reloadData()
            }
        }
    }
}
