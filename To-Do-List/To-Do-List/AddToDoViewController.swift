//
//  AddToDoViewController.swift
//  To-Do-List
//
//  Created by Clark Chen on 2/20/16.
//  Copyright © 2016 ClarkChen. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    var toDoItem: ToDoItem?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if sender as? NSObject != self.doneButton{ // then it is cancel button
            print("Cancel button pressed!")
            return // do nothing
        }
        if self.textField.text != nil && self.textField.text!.characters.count > 0 { //done button pressed AND text is not empty
            var txt = "text entered: " + self.textField.text!
            print(txt)
            print("something typed in AND done pressed = make a new item!")
            self.toDoItem = ToDoItem(name: self.textField.text!) //make a new to do item
        }
    }
    
    
}

