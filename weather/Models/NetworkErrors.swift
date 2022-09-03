//
//  Errors.swift
//  weather
//
//  Created by Andriy Biguniak on 03.09.2022.
//

import Foundation

enum NetworkErrors : Error {
    case wrongURL
    case UrlSessionError
    case badResponseStatusCode
    case serializationError
}
