//
//  UserCityViewController.swift
//  CityDetails
//
//  Created by Kashish Rastogi on 31/07/21.
//

import UIKit
import CoreData
class UserCityViewController: UIViewController {

    @IBOutlet weak var CityCollection: UICollectionView!
    private let CellIdentifier = "CellIdentifier"
    var locations  = [BookMarkedCity]()
    
    override func viewDidLoad() {
        self.title = "Bookmarked Cities"
        CityCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier)

        self.GetBookMatckedCityList { (error) in
            if let err = error
            {
                
            }
            else
            {
                CityCollection.reloadData();
            }
            
        };
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func GetBookMatckedCityList(completion:(Error?) -> Void){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
          }
          
          // 1
          let managedContext =
            appDelegate.persistentContainer.viewContext
        
         // Where Locations = your NSManaged Class

        do
        {
        let r = NSFetchRequest<NSFetchRequestResult>(entityName: "BookMarkedCity")
        let f = try managedContext.fetch(r)
        locations = f as! [BookMarkedCity]
           } catch let error as NSError {
               print("woe grabAllPersons \(error)")
           }
        
        
        
        // Then you can use your properties.

        completion(nil)

    }
    
}

extension UserCityViewController: UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
      
}
