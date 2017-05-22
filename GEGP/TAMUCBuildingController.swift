//
//  File.swift
//  GEGP
//
//  Created by Eric Fry on 4/26/17.
//  Copyright © 2017 Eric Fry. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import CoreData


class TAMUCBuildingCotroller: NSObject {
    
    public static let BUILDING_ADDED_NOTIFICATION = NSNotification.Name("BUILDING_ADDED")
    
    static let buildingClassName: String = String(describing: AddedMapPin.self)
    static var buildingsArray: Array = Array<MapPin>()
    
    class func sharedBuildings() -> Array<Any>{return buildingsArray}
    
    class func addBuilding(building: MapPin) {
        TAMUCBuildingCotroller.buildingsArray.insert(building, at: 0)
        
        
        let newBuildingEntity:AddedMapPin = NSEntityDescription.insertNewObject(forEntityName: buildingClassName, into: DatabaseController.getContext()) as! AddedMapPin
        newBuildingEntity.pinTitle = building.title
        newBuildingEntity.pinDescription = building.subtitle
        newBuildingEntity.pinLatitude = building.coordinate.latitude
        newBuildingEntity.pinLongitude = building.coordinate.longitude
        newBuildingEntity.pinImage = building.imageStringURL
        
        
        
        NotificationCenter.default.post(name: BUILDING_ADDED_NOTIFICATION, object: building)
    }
    
    class func loadBuildings() {
        Alamofire.request("http://erickfry.com/json/taggedLocations.json").responseString{ response in
            do {
                let jsonString = response.result.value!
                let jsonData = jsonString.data(using: .utf8)!
                let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! NSArray
                
                for (_, jsonObject) in jsonArray.enumerated(){
                    let currentBuilding:Dictionary = jsonObject as! Dictionary<String, AnyObject>
                    
                    let NAME_KEY = "name"
                    let LOCATION_KEY = "location"
                    let DESCRIPTION_KEY = "description"
                    let LATITUDE_KEY = "latitude"
                    let LONGITUDE_KEY = "longitude"
                    let IMAGEURL_KEY = "imageURL"
                    
                    let nameString:String = currentBuilding[NAME_KEY] as! String
                    let descriptionString:String = currentBuilding[DESCRIPTION_KEY] as! String
                    
                    let locationDictionary:Dictionary = currentBuilding[LOCATION_KEY] as! Dictionary<String, Double>
                    let latitude:Double = locationDictionary[LATITUDE_KEY]! as Double
                    let longitude:Double = locationDictionary[LONGITUDE_KEY]! as Double
                    
                    let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                    
                    let image:String = currentBuilding[IMAGEURL_KEY] as! String
                    
                    let currentMapPin:MapPin = MapPin(title: nameString, subtitle: descriptionString, coordinate: location, image: image)
                    print("\(image)")
                    TAMUCBuildingCotroller.addBuilding(building: currentMapPin)
                }
            }
            catch {
                print("error calling Alamofire")
            }
        }
        
        print("called Alamofire")
    }

}
