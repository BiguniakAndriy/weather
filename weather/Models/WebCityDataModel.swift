//
//  WebCityDataModel.swift
//  weather
//
//  Created by Andriy Biguniak on 29.08.2022.
//

import Foundation

// MARK: - WebCityDataModel
struct WebCityDataModel: Codable {
    var name: String
    var lat, lon: Double
}
