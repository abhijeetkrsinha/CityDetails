//
//  BaseParser.swift
//  CityDetails
//
//  Created by Kashish Rastogi on 31/07/21.
//

import Foundation


class BaseParser: NSObject {

    
    public typealias ParsingCompletionHandler = (Data?, Error?) -> Void

    
    public let WeatherAPIKey = "fae7190d7e6433ec3a45285ffcf55c86"
    private let WeatherAPIBaseUrl = "https://api.openweathermap.org/data/2.5/"

    func GetDataFromService(parameterString:String, completion:  @escaping ParsingCompletionHandler ){
       
        
        let finalUrlString = WeatherAPIBaseUrl + parameterString
        
        let request: URLRequest? = URLRequest(url: URL.init(string: finalUrlString)!)

        let task1 = URLSession.shared.dataTask(
                    with: request!,
                    completionHandler: { data, response, error in
                        
                        completion(data,error)
                        
                        

                    })
        task1.resume()

    }
    
    func ParseData()
    {
        
    }
    
}
