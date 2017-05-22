//
//  TAMUCAnnonatation.swift
//  GEGP
//
//  Created by Eric Fry on 4/25/17.
//  Copyright © 2017 Eric Fry. All rights reserved.
//

import MapKit

class MapPin: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var imageStringURL: String?
    
    
    //var mapPinDescription: String{return "\(title): \(subtitle)"}
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, image: String?) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.imageStringURL = image
    }
        
}
