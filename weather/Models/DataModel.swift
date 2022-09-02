//
//  WeatherModel.swift
//  TestProject_Weather
//
//  Created by Andriy Biguniak on 02.08.2022.
//

import Foundation

// data model
struct DataModel {
    var city              : CityModel
    var weather           : PresentationWeatherModel
    var temperatureFormat : TemperatureFormat
    
    func getTemperature(mainTemp: Bool) -> String {
        
        // mainTemp or feelsLike
        let temp = mainTemp == true ? self.weather.temp : self.weather.tempFeelsLike
        
        switch self.temperatureFormat {
        case .fahrenheit:
            return String(Int((temp - 273.15) * 1.8 + 32)) + " " + TemperatureFormat.fahrenheit.rawValue
        case .celsius:
            return String(Int(temp - 273.15)) + " " + TemperatureFormat.celsius.rawValue
        case .kelvin:
            return String(Int(temp)) + " " + TemperatureFormat.kelvin.rawValue
        }
    }
}

struct PresentationWeatherModel {
    var description     : String
    var temp            : Double
    var tempFeelsLike   : Double
    var humidity        : Int
    var pressure        : Int
    var windSpeed       : Double
    
    init(weatherFromWeb: WebWeatherModel) {
        self.description = "Current weather"
        self.temp = weatherFromWeb.main.temp
        self.tempFeelsLike = weatherFromWeb.main.feelsLike
        self.humidity = weatherFromWeb.main.humidity
        self.pressure = weatherFromWeb.main.pressure
        self.windSpeed = weatherFromWeb.wind.speed
    }
    
}
