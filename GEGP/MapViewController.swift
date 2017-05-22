//
//  MapViewController.swift
//  GEGP
//
//  Created by Eric Fry on 3/1/17.
//  Copyright © 2017 Eric Fry. All rights reserved.
//
import UIKit
import MapKit
import FBSDKLoginKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    //var locationManager: CLLocationManager?
    
    //var currentLocation: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        NotificationCenter.default.addObserver(forName: TAMUCBuildingCotroller.BUILDING_ADDED_NOTIFICATION, object: nil, queue: nil) {notification in
            let newBuildingPin:MapPin = notification.object as! MapPin
            
            self.mapView.addAnnotation(newBuildingPin)
            //self.mapView.annotat
            self.mapView.zoomIn(coordinate: LocationsController.deviceLocation())
            self.mapView.showsBuildings = true
            self.mapView.showsCompass = true
            self.mapView.showsUserLocation = true
        }
        self.mapView.delegate = self
        let buildingArray:Array = TAMUCBuildingCotroller.sharedBuildings()
        for (_, currentObject) in buildingArray.enumerated(){
            let buildingPin:MapPin = currentObject as! MapPin
            
            mapView.addAnnotation(buildingPin)
        }
    }
    
    private struct Constants {
        static let PartialTrackColor = UIColor.green
        static let FullTrackColor = UIColor.blue.withAlphaComponent(0.5)
        static let TrackLineWidth: CGFloat = 3.0
        static let ZoomColldown = 1.5
        static let LeftCalloutFrame = CGRect(x: 0, y: 0, width: 59, height: 59)
        static let AnnotationViewReuseIdentifier = "taggedLocation"
        static let ShowImageSeque = "Show Image"
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.AnnotationViewReuseIdentifier)
        
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.AnnotationViewReuseIdentifier)
            view?.canShowCallout = true
        }
        else {
            view?.annotation = annotation
        }
        
        view?.rightCalloutAccessoryView = nil
        view?.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as UIButton
        //view?.rightCalloutAccessoryView = UIButton.init(type: .infoLight) as UIButton

        return view
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: Constants.ShowImageSeque, sender: view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.ShowImageSeque {
            if let tag = (sender as? MKAnnotationView)?.annotation as? MapPin{
                if let ivc = segue.destination as? ImageViewController {
                    ivc.imageURL = tag.imageStringURL!
                    ivc.title = tag.title!
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapType.standard;
            break;
        case 1:
            self.mapView.mapType = MKMapType.hybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapType.satellite;
            break;
        default:
            break;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MKMapView{
    func zoomIn(coordinate: CLLocationCoordinate2D, withLevel level:CLLocationDistance = 2000){
        let camera =
            MKMapCamera(lookingAtCenter: coordinate, fromEyeCoordinate: coordinate, eyeAltitude: level)
        self.setCamera(camera, animated: true)
    }
}
