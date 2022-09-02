//
//  NetworkManager.swift
//  TestProject_Weather
//
//  Created by Andriy Biguniak on 02.08.2022.
//

import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    private let geoKey = "77c397e18c0e3212a7b37a225f13aba2"
    
    // get city coordinates
    func getCityCoordinates(cityName: String) async throws -> [Double] {
        
        // check url
        guard let jsonUrl = URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(cityName)&limit=5&appid=\(self.geoKey)")
        else { throw NSError() }

        do {
            // get data
            let (data, response) = try await URLSession.shared.data(from: jsonUrl)
            guard (response as? HTTPURLResponse)?.statusCode == 200
            else { throw NSError() }
            guard let city = try JSONDecoder().decode([WebCityDataModel].self, from: data).first
            else { throw NSError() }
            return [city.lat, city.lon]
        }
        catch let error { throw error }
    }
    
    // get weather
    func getWeather(cityName: String) async throws -> WebWeatherModel {
        
        do {
            // get city coordinates
            let coordinates = try await getCityCoordinates(cityName: cityName)
            
            // check coordinates and url
            guard !coordinates.isEmpty,
                  let url = URL(string:
                    "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates[0])&lon=\(coordinates[1])&appid=\(self.geoKey)")
            else { throw NSError() }
            
            // get weather
            let (data, _) = try await URLSession.shared.data(from: url)
            let webWeatherModel = try JSONDecoder().decode(WebWeatherModel.self, from: data)
            return webWeatherModel
        }
        catch let error { throw error }
    }
    
} // class end
