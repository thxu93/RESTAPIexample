//
//  ViewController.swift
//  RestAPI
//
//  Created by Thomas Xu on 2/20/16.
//  Copyright © 2016 Thomas Xu. All rights reserved.
//

import UIKit
import Foundation

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
       
        let postEndpoint: String = "http://terminal2.expedia.com/x/mflights/search?departureAirport=" + myDeparture.text! + "&arrivalAirport=" + myArrival.text! + "&departureDate=" + selectedDate.text! + "&childTravelerAge=2&apikey=wc1LMMNRaHdJhHzpLTMdOlNbRSTRsPTU"
        print (postEndpoint)
        //The guard statement lets us check that the URL we’ve provided is valid. !we can take out later
        guard let url = NSURL(string: postEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = NSURLRequest(URL: url)
        
        //Then we need an NSURLSession to use to send the request
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        //Then create the data task
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
            // do stuff with response, data & error here
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET on /posts/1")
                print(error)
                return
            }
            // parse the result as JSON, since that's what the API provides
            let post: NSDictionary
            do {
                post = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: []) as! NSDictionary
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            // now we have the post, let's just print it to prove we can access it
            print("The post is: " + post.description)
            
            // the post object is a dictionary
            // so we just access the title using the "title" key
            // so check for a title and print it if we have one
            if let postTitle = post["title"] as? String {
                print("The title is: " + postTitle)
            }
        })
        task.resume()
        
//        let url : String = "http://terminal2.expedia.com/x/mflights/search?departureAirport=" + myDeparture.text! + "&arrivalAirport=" + myArrival.text! + "&departureDate=" + selectedDate.text! + "&childTravelerAge=2&apikey=wc1LMMNRaHdJhHzpLTMdOlNbRSTRsPTU"
//        print(url)
//        
//        var request : NSMutableURLRequest = NSMutableURLRequest()
//        request.URL = NSURL(string: url)
//        request.HTTPMethod = "GET"
//
//        let call = NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
//          let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary
//
//            if (jsonResult != nil) {
//                print(jsonResult)s
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

