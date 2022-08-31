//
//  WeatherModel.swift
//  TestProject_Weather
//
//  Created by Andriy Biguniak on 02.08.2022.
//

import Foundation

// data model
struct WeatherModel {
    var city              : CityModel
    var weather           : PresentationWeatherModel
    var temperatureFormat : TemperatureFormat
    
    func getTemperature(mainTemp: Bool) -> String {
        
        // mainTemp or feelsLike
        let temp = mainTemp == true ? self.weather.temp : self.weather.tempFeelsLike
        
        switch self.temperatureFormat {
        case .fahrenheit:
            return String((temp - 273.15) * 1.8 + 32)+" °F"
        case .celsius:
            return String(temp - 273.15)+" °C"
        case .kelvin:
            return String(temp)+" K"
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
        self.description = "description"
        self.temp = weatherFromWeb.main.temp
        self.tempFeelsLike = weatherFromWeb.main.feelsLike
        self.humidity = weatherFromWeb.main.humidity
        self.pressure = weatherFromWeb.main.pressure
        self.windSpeed = weatherFromWeb.wind.speed
    }
    
}
