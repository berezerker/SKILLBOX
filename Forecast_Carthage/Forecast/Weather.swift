//
//  Cathegory.swift
//  Forecast
//
//  Created by Berezkin on 01.07.2020.
//  Copyright © 2020 Berezkin. All rights reserved.
//

import Foundation

func string(from timestamp: Double) -> String {
    if let timeInterval = TimeInterval(String(timestamp)) {
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd июня"
        
        return formatter.string(from: date)
    }
    return "" //return empty if somehow the timestamp conversion to TimeInterval (Double) fails
}

@objc public class dailyForecast: NSObject, Codable{
    var daily: [Weather]?
    enum CodingKeys: String, CodingKey{
        case daily = "daily"
    }
}

struct Temperature: Codable{
    let min: Double?
    let max: Double?
    let day: Double?
    enum CodingKeys: String, CodingKey{
        case min = "min"
        case max = "max"
        case day = "day"
    }
}

struct WeatherInfo: Codable{
    let description: String?
    let icon: String?
    enum CodingKeys: String, CodingKey{
        case description = "description"
        case icon = "icon"
    }
}

@objc public class Current: NSObject, Codable{
    let current: CurrentWeather?
    let hourly: [CurrentWeather]?
    
    enum CodingKeys: String, CodingKey{
        case current = "current"
        case hourly = "hourly"
    }
}

class CurrentWeather: Codable{
    let dt: Double?
    let temp: Double?
    let weather: [WeatherInfo?]
    let feels_like: Double?
    
    enum CodingKeys: String, CodingKey{
        case dt = "dt"
        case temp = "temp"
        case weather = "weather"
        case feels_like = "feels_like"
    }
}

class Weather: Codable{
    let dt: Double?
    let temp: Temperature?
    let weather: [WeatherInfo?]
    
    enum CodingKeys: String, CodingKey{
        case dt = "dt"
        case temp = "temp"
        case weather = "weather"
    }
    
}

