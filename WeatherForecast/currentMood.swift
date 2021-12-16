//
//  currentMood.swift
//  WeatherForecast
//
//  Created by Vahit Emre TELLİER on 12.12.2021.
//

import Foundation
import UIKit

//
struct CurrentMood {
    
    let tempature : Double
    let precipitation : Double
    let summary : String
    let humidity : Double
    let img : String
    
    init(tempature : Double, precipitation : Double, summary : String, humidity : Double, img : String){
        self.tempature = tempature
        self.precipitation = precipitation
        self.summary = summary
        self.humidity = humidity
        self.img = img
    }
    
}

extension CurrentMood {
    
    var wheatherImage : UIImage {
    
        switch img {
            
        case "clear-day" : return UIImage(named: "clear-day")!
        case "clear-night" : return UIImage(named: "clear-night")!
        case "rain" : return UIImage(named: "rain")!
        case "cloudy" : return UIImage(named: "cloudy")!
        case "fog" : return UIImage(named: "fog")!
        case "partly-cloudy-day" : return UIImage(named: "partly-cloudy-day")!
        case "partly-cloudy-night" : return UIImage(named: "partly-cloudy-night")!
        case "sleet" : return UIImage(named: "sleet")!
        case "snow" : return UIImage(named: "snow")!
        default:
            return UIImage(named: "wind")!
        }
    }
}
