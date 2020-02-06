//
//  FourDayForecastData.swift
//  My Weather App
//
//  Created by Konstantinos Christopoulos on 5/2/20.


import Foundation

struct FourDayForecastData: Decodable {
    
    
    let list: [List]
    


struct Main: Decodable  {
    let temp : Double
}

struct List: Decodable {
    let main: Main
    let weather: [Weather]
}
    
    struct Weather: Decodable {
        let id: Int
    }
}


