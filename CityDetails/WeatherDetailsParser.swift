//
//  WeatherDetailsParser.swift
//  CityDetails
//
//  Created by Kashish Rastogi on 31/07/21.
//

import UIKit

class WeatherDetailsParser: BaseParser {

    func GetWeatherDetails(latitude:Double, longitude: Double, completion: @escaping (WeatherAPIDetailsBO?, Error?) -> Void) {
        let parameterString = "weather?lat=\(latitude)&lon=\(longitude)&appid=\(WeatherAPIKey)"
        self.GetDataFromService(parameterString: parameterString) { (data, error) in
            if let location = data
            {
                    do {
                        let decoded = try JSONDecoder().decode(WeatherAPIDetailsBO.self, from: location)
                        completion(decoded,nil)
                    } catch {
                        completion(nil,error)
                    }
            }
        }
    }
    
    
    func GetWeatherDetailsForNextFiveDays(latitude:Double, longitude: Double, completion: @escaping (PlaceWeatherList?, Error?) -> Void) {
        let parameterString = "forecast?lat=\(latitude)&lon=\(longitude)&appid=\(WeatherAPIKey)"
        self.GetDataFromService(parameterString: parameterString) { (data, error) in
            if let location = data
            {
                    do {
                        let decoded = try JSONDecoder().decode(PlaceWeatherList.self, from: location)
                        completion(decoded,nil)
                    } catch {
                        print(error.localizedDescription)
                        completion(nil,error)
                    }
            }
        }
    }
    
    
    func GetWeatherDetail1s(latitude:Double) {
    }
}
