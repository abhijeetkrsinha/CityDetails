//
//  WeatherAPIDetailsBO.swift
//  CityDetails
//
//  Created by Kashish Rastogi on 31/07/21.
//


struct WeatherAPIDetailsBO: Decodable {
    let visibility:Double
    let dt:Double
    var timezone:Double
    var id:Double
    var name:String
    var coord:CoOrdinates
    var weather:[Weather]
}

struct WeatherDetailsBOFiveDays: Decodable {
    let dt:Double
    let visibility:Double
    let pop:Double
    let main:MainDetails
    var dt_txt:String
    var weather:[Weather]

}

struct MainDetails: Decodable
{
    var temp:Double
    var feels_like:Double
    var temp_min:Double
    var temp_max:Double
    var pressure:Int
    var sea_level:Int
    var grnd_level:Int
    var humidity:Int
    var temp_kf:Double

   
}


struct CoOrdinates: Decodable
{
    var lat:Double
    var lon:Double

}

struct Weather: Decodable
{
    var id:Double
    var main:String
    var description:String
    var icon:String

}
