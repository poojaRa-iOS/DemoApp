//
//  WeatherData.swift
//  SampleAppWeatherReport
//
//  Created by Pooja Raghuwanshi on 15/07/25.
//

import Foundation

struct CoordinateData: Decodable {
    let lat: Double?
    let lon: Double?
    let name: String?
}

struct WeatherData: Decodable {
    let main: Main?
    let weather: [Weather]?
    let name: String?
}

struct Main: Decodable {
    let temp: Double?
}

struct Weather: Decodable {
    let main: String?
    let icon: String?
}
