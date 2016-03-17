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
//            print("The post is: " + post.description)
            
            
            if let legs = post as NSDictionary! { // grabs every object in the dictionary
             
                if let offers = legs["offers"] as? NSArray { // We get all the offers
                    
                        var ticketPrices = [String]()
                        
                        for (var i = 0; i < offers.count; i++) {
                            
                            // For each offer we grab the ticket price information
                            if let avgPrice = offers[i] as? NSDictionary {
                                
                                // We grab the object called averageTotalPricePerTicket
                                if let avgPrice = avgPrice["averageTotalPricePerTicket"] as? NSDictionary {
                                    
                                    // We grab the value of amount of the ticket price. amount is the key
                                    if let amount = avgPrice["amount"] as? NSString {
                                        
                                        // We add the price to our array
                                        ticketPrices.append(amount as String)
                                    }
                                }
                            }
                        }
                        // Print the contents of the array, this is all the ticket prices we got back
                        for (var k = 0; k < ticketPrices.count; k++) {
//                            print(ticketPrices[k])
                        }
                        
                        // Finds the cheapest ticket
                        var min = 999999.00;
                        var location = ticketPrices[0];
                        var m = 0;
                    
                        for (var l = 0; l < ticketPrices.count; l++) {

                            let x = Double(ticketPrices[l])!
      
                            if (x < min) {
                                min = x
                                location = ticketPrices[l]
                                m = l;
                            }
                        }
                    
                        print("Cheapest ticket price: ")
                        print(location) //gets the price of that flight - one way
                        print((offers[m]["detailsUrl"]) as! String) // prints the details url to that flight, Note: only does one way
                        print((offers[m]["seatsRemaining"] as! Int),  "Seats Left!"); // prints out how many seats are remaining
                    }
                }
            
            /** I don't think we need this statement */

            // the post object is a dictionary
            // so we just access the title using the "title" key
            // so check for a title and print it if we have one
//            if let postTitle = post["title"] as? String {
//                print("The title is: " + postTitle)
//            }
        })
        task.resume()
        
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

