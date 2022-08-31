//
//  WebWeatherModel.swift
//  weather
//
//  Created by Andriy Biguniak on 29.08.2022.
//

import Foundation

// MARK: - WebWeatherModel
struct WebWeatherModel: Codable {
    let main: Main
    let wind: Wind
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
}

