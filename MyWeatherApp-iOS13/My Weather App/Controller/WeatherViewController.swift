//
//  WeatherModel.swift
//  My Weather App
//
//  Created by Konstantinos Christopoulos on 16/1/20.


import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var dayOneTemperature: UILabel!
    @IBOutlet weak var dayTwoTemperature: UILabel!
    @IBOutlet weak var dayThreeTemperature: UILabel!
    @IBOutlet weak var dayFourTemperature: UILabel!
    @IBOutlet weak var dayOneConditionLabel: UIImageView!
    @IBOutlet weak var dayTwoConditionLabel: UIImageView!
    @IBOutlet weak var dayThreeConditionLabel: UIImageView!
    @IBOutlet weak var dayFourConditionLabel: UIImageView!
    
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
   
        locationManager.requestLocation()
    }
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
}

//MARK: - UITextFieldDelegate


extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        //searchTextField.text
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter City Name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempratureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didUpdateForecast(_ weatherManager: WeatherManager, weather: FourDayForecastModel) {
          DispatchQueue.main.async {
            self.dayOneTemperature.text = weather.temperatureString(temp: weather.temperatureOne)
            self.dayOneConditionLabel.image = UIImage(systemName: weather.conditionOne)
            
            self.dayTwoTemperature.text = weather.temperatureString(temp: weather.temperatureTwo)
            self.dayTwoConditionLabel.image = UIImage(systemName: weather.conditionTwo)

            self.dayThreeTemperature.text = weather.temperatureString(temp: weather.temperatureThree)
            self.dayThreeConditionLabel.image = UIImage(systemName: weather.conditionThree)

            self.dayFourTemperature.text = weather.temperatureString(temp: weather.temperatureFour)
            self.dayFourConditionLabel.image = UIImage(systemName: weather.conditionFour)
          }
      }

    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: -CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longtitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
