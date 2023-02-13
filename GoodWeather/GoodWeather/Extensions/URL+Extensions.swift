//
//  URL+Extensions.swift
//  GoodWeather
//
//  Created by raul.santos on 02/02/23.
//

import Foundation


extension URL {
    
    static func urlForWeatherAPI(city: String) -> URL? {
        
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=43b3ce48cff195221be5fd2fbcb57ae1&units=metric")
        
    }
    
}
