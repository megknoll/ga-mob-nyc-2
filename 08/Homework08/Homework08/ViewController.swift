//
//  ViewController.swift
//  Homework08
//
//  Created by Meghan Knoll on 4/19/15.
//  Copyright (c) 2015 Meghan Knoll. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var weatherData = WeatherDataModel()
    var weatherDataSwifty = WeatherDataModel()
    
    //TODO one: Write and call a function that make a successful network connection to google.com using core networking APIs, then print out the results.
    func connectToGoogle(){
        let url = NSURL(string: "http://www.google.com")
        var request: NSURLRequest = NSURLRequest(URL: url!)
        var response: NSURLResponse?
        
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
        
        if let httpResponse = response as? NSHTTPURLResponse {
            let response = httpResponse.statusCode
            let body = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            println("\n\nTODO ONE ANSWER:")
            println("google response code: \(response)")
            //println("google response body: \(body)")
        }
    }
    
    //TODO two: Write and call a function that makes a failing network connection (using core networking APIs) to http://generalassemb.ly/foobar.baz, a nonexistant page. Print out the status code and body of the response.
    func connectToFoobar(){
        let url = NSURL(string: "http://generalassemb.ly/foobar.baz")
        var request: NSURLRequest = NSURLRequest(URL: url!)
        var response: NSURLResponse?
        
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
        
        if let httpResponse = response as? NSHTTPURLResponse {
            let response = httpResponse.statusCode
            let body = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            println("\n\nTODO TWO ANSWER:")
            println("foobar response code: \(response)")
            //println("foobar response body: \(body)")
        }
    }
    
    //TODO three: Make a successful network connection to http://api.openweathermap.org/data/2.5/weather?q=New%20York,US, an API that speaks JSON using core networking APIs. Create a model class that corresponds to the JSON response object, populate it with the contents of that JSON using NSJSONSerialization, then print out the model.
    func connectToWeather(){
        
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=New%20York,US,")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: nil) as! NSDictionary
            
            self.weatherData.name = responseDictionary["name"] as! String
            self.weatherData.base = responseDictionary["base"] as! String
            self.weatherData.id = responseDictionary["id"] as! NSNumber
            self.weatherData.dt = responseDictionary["dt"] as! NSNumber
            self.weatherData.cod = responseDictionary["cod"] as! NSNumber
            
            self.weatherData.main = responseDictionary["main"] as! NSDictionary
            self.weatherData.clouds = responseDictionary["clouds"] as! NSDictionary
            self.weatherData.coord = responseDictionary["coord"] as! NSDictionary
            self.weatherData.sys = responseDictionary["sys"] as! NSDictionary
            var weatherParent = responseDictionary["weather"] as! NSArray
            self.weatherData.weather = weatherParent[0] as! NSDictionary
            self.weatherData.wind = responseDictionary["wind"] as! NSDictionary
            
            println("\n\nTODO THREE ANSWER:")
            self.weatherData.printWeather()
        })
        
        task.resume()
    }
    
    func convertDictionary(dict: [String : JSON]) -> [String : String] {
        var result = [String : String]()
        
        for (key, value) in dict {
            result[key] = value.stringValue
        }
        return result
    }
    
    //TODO four: Make a successful network connection to http://api.openweathermap.org/data/2.5/weather?q=New%20York,US, an API that speaks JSON. Populate a your above-defined model with the contents of that JSON using SwiftyJSON, then print out the model.
    func connectToWeatherSwifty(){
    
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=New%20York,US,")!

        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        
            var responseData = JSON(data: data)
            
            self.weatherDataSwifty.name =  responseData["name"].stringValue
            self.weatherDataSwifty.base =  responseData["base"].stringValue
            self.weatherDataSwifty.id =  responseData["id"].numberValue
            self.weatherDataSwifty.dt =  responseData["dt"].numberValue
            self.weatherDataSwifty.cod =  responseData["cod"].numberValue
            
            self.weatherDataSwifty.main = self.convertDictionary(responseData["main"].dictionaryValue)
            self.weatherDataSwifty.clouds = self.convertDictionary(responseData["clouds"].dictionaryValue)
            self.weatherDataSwifty.coord = self.convertDictionary(responseData["coord"].dictionaryValue)
            self.weatherDataSwifty.sys = self.convertDictionary(responseData["sys"].dictionaryValue)
            self.weatherDataSwifty.wind = self.convertDictionary(responseData["wind"].dictionaryValue)
            self.weatherDataSwifty.weather = self.convertDictionary(responseData["weather"][0].dictionaryValue)
            
            println("\n\nTODO FOUR ANSWER:")
            self.weatherDataSwifty.printWeather()
        })
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectToGoogle()
        connectToFoobar()
        connectToWeather()
        connectToWeatherSwifty()
    }
}

