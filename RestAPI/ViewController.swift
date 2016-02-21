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
    
    //sets the date to label
    @IBAction func datePickerAction(sender: AnyObject) {
        
        let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.stringFromDate(myDatePicker.date)
        print(strDate)
        
        
        self.selectedDate.text = strDate
        
    }
    

    
    @IBAction func makeTheCall(sender: AnyObject) {
        
        let url : String = "http://terminal2.expedia.com/x/mflights/search?departureAirport=" + myDeparture.text! + "&arrivalAirport=" + myArrival.text! + "&departureDate=" + selectedDate.text! + "&childTravelerAge=2&apikey=wc1LMMNRaHdJhHzpLTMdOlNbRSTRsPTU"
        print(url)
        
        
        
//        var request : NSMutableURLRequest = NSMutableURLRequest()
//        request.URL = NSURL(string: url)
//        request.HTTPMethod = "GET"
//        
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
//            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
//            
//            if (jsonResult != nil) {
//                // process jsonResult
//            } else {
//                // couldn't load JSON, look at error
//            }
//            
//            
//        })
    
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

