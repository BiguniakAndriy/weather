//
//  CityTypeModel.swift
//  TestProject_Weather
//
//  Created by Andriy Biguniak on 02.08.2022.
//

import Foundation

// city data model
struct CityModel {
    var name        : String
    var size        : CityType
    var coordinates : [Double] = [0.0, 0.0]
    
    static let cities = [
        CityModel(name: "Kyiv", size: .big),
        CityModel(name: "Ternopil", size: .medium),
        CityModel(name: "Odesa", size: .big),
        CityModel(name: "Buchach", size: .small)
    ]
    
}


// types of city size
enum CityType : String {
    case small  = "Small"
    case medium = "Middle"
    case big    = "Big"
}






