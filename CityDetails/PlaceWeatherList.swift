//
//  PlaceWeatherList.swift
//  CityDetails
//
//  Created by Kashish Rastogi on 31/07/21.
//

import UIKit

struct PlaceWeatherList : Decodable{
    var list:[WeatherDetailsBOFiveDays]
    var city:CityParserBO
    
    
}




struct CityParserBO : Decodable {
    var id:Double
    var name:String
    var population:Double = 0
    var timezone:Double = 0
    var sunrise:Double = 0
    var sunset:Double = 0

    
    
}
