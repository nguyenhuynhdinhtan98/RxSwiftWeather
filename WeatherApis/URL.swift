//
//  URL.swift
//  WeatherApis
//
//  Created by tantest on 30/08/2022.
//

import Foundation


extension URL {
    static func urlWeatherApis(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=09ef5a52ede47de751c4a2de1e85f191")!
    }
}
