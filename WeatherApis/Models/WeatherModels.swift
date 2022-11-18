//
//  WeatherModels.swift
//  WeatherApis
//
//  Created by tantest on 30/08/2022.
//

import Foundation

// MARK: - Welcome
struct WeatherModels: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}


extension WeatherModels {
    static var empty: WeatherModels {
        return WeatherModels(coord: nil, weather: nil, base: "", main: Main(temp: 0.0 , feelsLike: 0.0, tempMin: 0.0, tempMax: 0.0, pressure: 0, humidity: 0), visibility: 0, wind: nil, clouds: nil, dt: 0, sys: nil, timezone: 0, id: 0, name: "", cod: 0)
    }
}
