//
//  SelectionViewModel.swift
//  weather
//
//  Created by Andriy Biguniak on 01.09.2022.
//

import Foundation


class SelectionViewModel {
    
    // MARK: = VARs
    
    let cities = CityModel.cities
    
    
    // MARK: - FETCH data
    
    func fetchData(cityIndex: Int, temperatureIndex: Int) async -> DataModel? {
        
        //get city
        let city = self.cities[cityIndex]
        
        //get web weather model
        guard let webWeatherModel = await NetworkManager.shared.getWeather(cityName: city.name)
        else {
            print("ERROR: Can`t get weather")
            return nil
        }
        
        // create weather model
        let weather = PresentationWeatherModel(weatherFromWeb: webWeatherModel)
        
        // create data model
        let dataModel = DataModel(
            city: city,
            weather: weather,
            temperatureFormat: checkTemperatureFormat(index: temperatureIndex)
        )
        
        return dataModel
    }
    
    
    // MARK: - HELPERS
    
    private func checkTemperatureFormat(index: Int) -> TemperatureFormat {
        switch index {
        case 0:
            return .celsius
        case 1:
            return .fahrenheit
        default:
            return .kelvin
        }
    }
    
}
