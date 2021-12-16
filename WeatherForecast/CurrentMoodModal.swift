//
//  CurrentMoodModal.swift
//  WeatherForecast
//
//  Created by Vahit Emre TELLİER on 12.12.2021.
//

import Foundation
import UIKit

struct CurrentMoodModal {
    
    let tempature : String
    let precipitation : String
    let summary : String
    let humidity : String
    let img : UIImage
    
    init(data : CurrentMood) {
        self.tempature = "\(Int((data.tempature - 32) / 1.8))°"
        self.precipitation = "\(Int(data.precipitation * 100))%"
        self.summary = data.summary
        self.humidity = "\(Int(data.humidity * 100))%"
        self.img = data.wheatherImage
    }
    
}
