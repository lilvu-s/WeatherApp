//
//  Model.swift
//  WeatherApp
//
//  Created by Ангеліна Семенченко on 30.03.2022.
//

import Foundation

struct Parsing: Decodable {
    let base: String
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    let weather: [Weather]
    let main: Main
    let clouds: Clouds
    let wind: Wind
    let sys: Sys
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Int
    let humidity: Int
}

struct Sys: Decodable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct Wind: Decodable {
    let speed: Float?
    let deg: Int
}

struct Clouds: Decodable {
    let all: Int
}
