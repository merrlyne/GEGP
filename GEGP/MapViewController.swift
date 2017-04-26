//
//  FirstViewController.swift
//  GEGP
//
//  Created by Eric Fry on 3/1/17.
//  Copyright © 2017 Eric Fry. All rights reserved.
//
import UIKit
import MapKit
import FBSDKLoginKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    //var locationManager: CLLocationManager?
    
    var currentLocation: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(forName: BuildingCotroller.BUILDING_ADDED_NOTIFICATION, object: nil, queue: nil) {notification in
            let newBuildingPin:MapPin = notification.object as! MapPin
            
            self.mapView.addAnnotation(newBuildingPin)
        }
    }
    
        

//        let distanceSpan: CLLocationDegrees = 2000
//        //let planoTXLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(33.00401188395153, -96.76447749137878)
//        
//        let JournalismBuilding: CLLocationCoordinate2D = CLLocationCoordinate2DMake(33.242752445937846, -95.904700756073)
//        
//        mapView.setRegion(MKCoordinateRegionMakeWithDistance(JournalismBuilding, distanceSpan, distanceSpan), animated: true)
//        
//        let tamucJourBuild = MapPin(title: "Journalism Building", subtitle: "Department of Computer Science and Information Systems", coordinate: JournalismBuilding)
//        
//        mapView.addAnnotation(tamucJourBuild)
        
//        locationManager = CLLocationManager()
//        locationManager?.delegate = self
        

    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        self.currentLocation = locations[0]
//        
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
    
    @IBAction func saveLocation(_ sender: Any) {
        
        //let titleString:String
        
    }
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
