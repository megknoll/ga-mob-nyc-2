// Assignment 8 playground

import XCPlayground
import UIKit

/*********************************************************************


NOTE:
FULL HOMEWORK ANSWER IS IN THE PROJECT VIEW CONTROLLER - PLAYGROUND KEPT CRASHING ON ME. 

- Meghan 

*********************************************************************/

// Let asynchronous code run
XCPSetExecutionShouldContinueIndefinitely()

//TODO one: Write and call a function that make a successful network connection to google.com using core networking APIs, then print out the results.

func connectToGoogle(){
    let url = NSURL(string: "http://www.google.com")
    var request: NSURLRequest = NSURLRequest(URL: url!)
    var response: NSURLResponse?
    
    var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
    
    if let httpResponse = response as? NSHTTPURLResponse {
        let response = httpResponse.statusCode
        let body = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        println("google response code: \(response)")
        println("google response body: \(body)")
    }
}
connectToGoogle()



//TODO two: Write and call a function that makes a failing network connection (using core networking APIs) to http://generalassemb.ly/foobar.baz, a nonexistant page. Print out the status code and body of the response.

func connectToFoobar(){
    let url = NSURL(string: "http://generalassemb.ly/foobar.baz")
    var request: NSURLRequest = NSURLRequest(URL: url!)
    var response: NSURLResponse?
    
    var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
    
    if let httpResponse = response as? NSHTTPURLResponse {
        let response = httpResponse.statusCode
        let body = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        println("foobar response code: \(response)")
        println("foobar response body: \(body)")
    }
}
connectToFoobar()



//TODO three: Make a successful network connection to http://api.openweathermap.org/data/2.5/weather?q=New%20York,US, an API that speaks JSON using core networking APIs. Create a model class that corresponds to the JSON response object, populate it with the contents of that JSON using NSJSONSerialization, then print out the model.



//TODO four: Make a successful network connection to http://api.openweathermap.org/data/2.5/weather?q=New%20York,US, an API that speaks JSON. Populate a your above-defined model with the contents of that JSON using SwiftyJSON, then print out the model.

