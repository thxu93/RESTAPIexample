//
//  ViewController.swift
//  RestAPI
//
//  Created by Thomas Xu on 2/20/16.
//  Copyright © 2016 Thomas Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var selectedDate: UILabel!

    
    @IBOutlet weak var myDeparture: UITextField!
    @IBOutlet weak var myArrival: UITextField!
    
    
    @IBAction func datePickerAction(sender: AnyObject) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.stringFromDate(myDatePicker.date)
        self.selectedDate.text = strDate
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }   


}

