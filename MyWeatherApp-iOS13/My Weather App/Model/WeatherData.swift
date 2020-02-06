//
//  WeatherData.swift
//  My Weather App
//
//  Created by Konstantinos Christopoulos on 16/1/20.


import Foundation


struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id : Int
    
}

