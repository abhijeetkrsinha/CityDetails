//
//  MapViewController.swift
//  CityDetails
//
//  Created by Kashish Rastogi on 31/07/21.
//

import UIKit
import MapKit
import CoreData
class MapViewController: UIViewController {

//    typealias ConfirmGeoLocation = (City) -> Void
    
    @IBOutlet weak var mapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureZ = UILongPressGestureRecognizer(target: self, action: #selector(self.revealRegionDetailsWithLongPressOnMap(sender:)))
        view.addGestureRecognizer(gestureZ)

        // Do any additional setup after loading the view.
    }
    @IBAction func revealRegionDetailsWithLongPressOnMap(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began { return }
        let touchLocation = sender.location(in: mapview)
        let locationCoordinate = mapview.convert(touchLocation, toCoordinateFrom: mapview)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        self.ConfirmLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude) { (city, error) in
            
            if error == nil
            {
                let alert = UIAlertController.init(title: "Confirm Location", message: "Are you sure you want to pin \(city?.Name ?? "") location", preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { (action) in
                    self.SaveCity(city: city)
                }))
                alert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: { (action) in
                    
                }))
                self.present(alert, animated: true) {
                    
                }

            }
            else
            {
                let alert = UIAlertController.init(title: "Error Getting Location", message: "Unable to get location details. Please try different location", preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { (action) in
                    
                }))
                alert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: { (action) in
                    
                }))
                self.present(alert, animated: true) {
                    
                }
            }
                    }
        
    }
    
    
    func SaveCity(city:City?)
    {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
          }
          
          // 1
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
        
        
        
        let cityToSave = BookMarkedCity(context: managedContext)

        cityToSave.name = city?.Name
        cityToSave.latitude = city!.Latitude
        cityToSave.longitude = city!.Longitude
        cityToSave.country = city?.Country
        cityToSave.countryCode = city?.CountryCode

        
         
        
          
          // 4
          do {
            try managedContext.save()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
          
    }
    
    func GetWeatherDetailsFromService(city:City?)
    {
        let parser =  WeatherDetailsParser();
        parser.GetWeatherDetails(latitude: city?.Latitude ?? 0, longitude: city?.Longitude ?? 0) { (object, error) in
            if error == nil
            {
                if let weatherObj:WeatherAPIDetailsBO = object
                {
                    print(weatherObj.name)
                }
            }
        }
    }
    
    
    func GetNextFiveDaysWeatherDetailsFromService(city:City?)
    {
        let parser =  WeatherDetailsParser();
        parser.GetWeatherDetailsForNextFiveDays(latitude: city?.Latitude ?? 0, longitude: city?.Longitude ?? 0) { (object, error) in
            if error == nil
            {
                if let weatherObj:PlaceWeatherList = object
                {
                    print(weatherObj.city.name)
                }
            }
        }
    }
    
    
    
    public typealias AddressCompletionHandler = (City?, Error?) -> Void

    
    func ConfirmLocation(latitude:CLLocationDegrees,longitude:CLLocationDegrees, completion :  @escaping AddressCompletionHandler) {
        
        let geocoder = CLGeocoder.init()
        
        geocoder.reverseGeocodeLocation(CLLocation.init(latitude: latitude, longitude: longitude), preferredLocale: nil) { (placemarks, error) in
            if error == nil
            {
                
                if let places = placemarks
                {
                    if places.count > 0 {
                        let P1 = places[0]
                        var city = City(Name: P1.locality!)
                        city.Latitude = latitude
                        city.Longitude = longitude
                        city.Country = P1.country
                        city.CountryCode = P1.isoCountryCode
                        completion(city, nil)
                    }
                }
                completion(nil, nil)
               
                
            }
            else
            {
                completion(nil, error)
            }
        }
        
        
        
    }

}
