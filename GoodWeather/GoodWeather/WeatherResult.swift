//
//  WeatherResult.swift
//  GoodWeather
//
//  Created by raul.santos on 01/02/23.
//

import Foundation
import UIKit


struct WeaterResult: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}

extension WeaterResult {
    
    static var empty: WeaterResult {
        return WeaterResult(main: Weather(temp: 0.0, humidity: 0.0))
    }
}
