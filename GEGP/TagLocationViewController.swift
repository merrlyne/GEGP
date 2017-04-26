//
//  TagLocationViewController.swift
//  GEGP
//
//  Created by Eric Fry on 4/26/17.
//  Copyright © 2017 Eric Fry. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TagLocationViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let nameString: String = nameTextField.text!
        
        
        let descriptionString: String = descriptionTextField.text!
        let newMapPin: MapPin = MapPin(title: nameString, subtitle: descriptionString, coordinate: CLLocationCoordinate2D(latitude: 33.242752445937846, longitude: -95.904700756073))
        
        BuildingCotroller.addBuilding(building: newMapPin)
                                       //MapViewController.mapView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

