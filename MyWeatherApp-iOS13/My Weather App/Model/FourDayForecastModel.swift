//
//  FourDayForecastModel.swift
//  My Weather App
//
//  Created by Konstantinos Christopoulos on 5/2/20.


import Foundation

struct FourDayForecastModel {
    let conditionIDOne: Int
    let conditionIDTwo: Int
    let conditionIDThree: Int
    let conditionIDFour: Int

    let temperatureOne: Double
    let temperatureTwo: Double
    let temperatureThree: Double
    let temperatureFour: Double

    
    func temperatureString(temp: Double) -> String {
        String(format: "%.0f",temp)
    }
    
    var conditionOne : String {
        switch (conditionIDOne){
                   case 200...232:
                       return "cloud.bolt"
                   case 300...321:
                       return "cloud.drizzle"
                   case 500...531:
                       return "cloud.rain"
                   case 600...622:
                       return "cloud.snow"
                   case 701...781:
                       return "cloud.fog"
                   case 800:
                       return "sun.max"
                   case 801...804:
                       return "cloud.bolt"
                   default:
                       return "cloud"
        }
        
    }
    
    var conditionTwo : String {
        switch (conditionIDTwo){
                   case 200...232:
                       return "cloud.bolt"
                   case 300...321:
                       return "cloud.drizzle"
                   case 500...531:
                       return "cloud.rain"
                   case 600...622:
                       return "cloud.snow"
                   case 701...781:
                       return "cloud.fog"
                   case 800:
                       return "sun.max"
                   case 801...804:
                       return "cloud.bolt"
                   default:
                       return "cloud"
        }
        
    }
    
    var conditionThree : String {
        switch (conditionIDTwo){
                   case 200...232:
                       return "cloud.bolt"
                   case 300...321:
                       return "cloud.drizzle"
                   case 500...531:
                       return "cloud.rain"
                   case 600...622:
                       return "cloud.snow"
                   case 701...781:
                       return "cloud.fog"
                   case 800:
                       return "sun.max"
                   case 801...804:
                       return "cloud.bolt"
                   default:
                       return "cloud"
        }
        
    }
    var conditionFour : String {
        switch (conditionIDTwo){
                   case 200...232:
                       return "cloud.bolt"
                   case 300...321:
                       return "cloud.drizzle"
                   case 500...531:
                       return "cloud.rain"
                   case 600...622:
                       return "cloud.snow"
                   case 701...781:
                       return "cloud.fog"
                   case 800:
                       return "sun.max"
                   case 801...804:
                       return "cloud.bolt"
                   default:
                       return "cloud"
        }
        
    }
}
