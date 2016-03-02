//
//  StatsViewController.swift
//  To-Do-List
//
//  Created by Clark Chen on 2/25/16.
//  Copyright © 2016 ClarkChen. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    // Mark: Properties
    
    @IBOutlet weak var numCompletedTasks: UILabel!
    var numCompleted = 0
    
    
    // Mark: Actions
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        numCompletedTasks.text = String(numCompleted)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
