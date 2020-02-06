//
//  WeatherManager.swift
//  My Weather App
//
//  Created by Konstantinos Christopoulos on 15/1/20.


import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather (_ weatherManager: WeatherManager, weather: WeatherModel)
    func didUpdateForecast (_ weatherManager: WeatherManager, weather: FourDayForecastModel)

    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=5dbcbb2a76b0cdff731578d033edab7d"
   let forecastURL = "https://api.openweathermap.org/data/2.5/forecast?&units=metric&appid=5dbcbb2a76b0cdff731578d033edab7d"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        let urlStringForecast = "\(forecastURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        performRequestForecast(urlString: urlStringForecast)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&units=metric&lat=\(latitude)&lon=\(longtitude)"
        let urlStringForecast = "\(forecastURL)&units=metric&lat=\(latitude)&lon=\(longtitude)"
        performRequestForecast(urlString: urlStringForecast)
        performRequest(urlString: urlString)
    }
    
    
    func performRequest(urlString: String){
        //1 create url
        if let url = URL(string: urlString){
            //2 create urlsession
            let session = URLSession(configuration: .default)
            //3 give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4 start the task
            task.resume()
        }
    }
    
    func performRequestForecast(urlString: String){
          //1 create url
          if let url = URL(string: urlString){
              //2 create urlsession
              let session = URLSession(configuration: .default)
              //3 give the session a task
              let task = session.dataTask(with: url) { (data, response, error) in
                  if error != nil {
                      self.delegate?.didFailWithError(error: error!)
                      return
                  }
                  if let safeData = data {
                      if let weather = self.parseJSONForecast(fourDayForecastData: safeData) {
                        self.delegate?.didUpdateForecast(self, weather: weather)
                      }
                  }
              }
              //4 start the task
              task.resume()
          }
      }
    
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temprature: temp)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseJSONForecast(fourDayForecastData: Data) -> FourDayForecastModel? {
           let decoder = JSONDecoder()
           do {
               let decodedData = try decoder.decode(FourDayForecastData.self, from: fourDayForecastData)
            let tempOne = decodedData.list[7].main.temp
            let idOne = decodedData.list[7].weather[0].id
            
            let tempTwo = decodedData.list[14].main.temp
            let idTwo = decodedData.list[14].weather[0].id

            let tempThree = decodedData.list[21].main.temp
            let idThree = decodedData.list[21].weather[0].id

            let tempFour = decodedData.list[28].main.temp
            let idFour = decodedData.list[28].weather[0].id

            let forecast = FourDayForecastModel(conditionIDOne: idOne, conditionIDTwo: idTwo, conditionIDThree: idThree, conditionIDFour: idFour, temperatureOne: tempOne, temperatureTwo: tempTwo, temperatureThree: tempThree, temperatureFour: tempFour)
               
               return forecast
           } catch {
               delegate?.didFailWithError(error: error)
               return nil
           }
       }
    
    
}


