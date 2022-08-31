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
