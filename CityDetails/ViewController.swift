//
//  ViewController.swift
//  CityDetails
//
//  Created by Kashish Rastogi on 30/07/21.
//

import UIKit
import GooglePlaces
class ViewController: UIViewController {
    private var placesClient: GMSPlacesClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()

        // Do any additional setuphi check after loading the view.
    }

    
    // Add a UIButton in Interface Builder, and connect the action to this function.
     @IBAction func getCurrentPlace(_ sender: UIButton) {
        let fields: GMSPlaceField = GMSPlaceField(rawValue:
          UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue))!

        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: fields) { [weak self] (placeLikelihoods, error) in
         guard let strongSelf = self else {
           return
         }

         guard error == nil else {
           print("Current place error: \(error?.localizedDescription ?? "")")
           return
         }

         guard let place = placeLikelihoods?.first?.place else {
           return
         }

       }
     }

}

