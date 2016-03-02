//
//  ToDoItem.swift
//  To-Do-List
//
//  Created by Clark Chen on 2/20/16.
//  Copyright © 2016 ClarkChen. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    
    var itemName: NSString = ""
    var completed: Bool = false
    var creationDate: NSDate = NSDate()
    
    
    //constructor
    init(name:String){
        self.itemName = name
        
    }
}
