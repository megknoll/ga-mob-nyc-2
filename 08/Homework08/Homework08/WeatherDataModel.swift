//
//  WeatherDataModel.swift
//  Homework08
//
//  Created by Meghan Knoll on 4/19/15.
//  Copyright (c) 2015 Meghan Knoll. All rights reserved.
//

import Foundation

class WeatherDataModel {
    var main : NSDictionary!
    var coord : NSDictionary!
    var sys : NSDictionary!
    var weather : NSDictionary!
    var clouds : NSDictionary!
    var wind : NSDictionary!
    
    var base = ""
    var name = ""
    var dt : NSNumber!
    var id : NSNumber!
    var cod : NSNumber!
    
    func printWeather(){
        println("name: \(name)")
        println("id: \(id)")
        println("dt: \(dt)")
        println("base: \(base)")
        println("cod: \(cod)")
        println("main: \(main)")
        println("coord: \(coord)")
        println("sys: \(sys)")
        println("weather: \(weather)")
        println("clouds: \(clouds)")
        println("wind: \(wind)")
    }
}
