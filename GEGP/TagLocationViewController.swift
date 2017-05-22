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

class TagLocationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var picker = UIImagePickerController()
    public var chosenImage:UIImage?
    var imageString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Tag Location" {
            navigationItem.title = "Cancel Tag"
        }
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        let nameString: String = nameTextField.text!
        
        
        let descriptionString: String = descriptionTextField.text!
        let newMapPin: MapPin = MapPin(title: nameString, subtitle: descriptionString, coordinate: LocationsController.deviceLocation(), image: imageString)
        
        TAMUCBuildingCotroller.addBuilding(building: newMapPin)
        
        self.dismiss(animated: true, completion: nil)
        
        DatabaseController.saveContext()
    }
    @IBAction func uploadFromCamera(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        }
        else {noCamera()}
    }
    
    @IBAction func uploadFromLibarary(_ sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .popover
        picker.popoverPresentationController?.barButtonItem = sender
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagePath = documentsPath?.appendingPathComponent("image.jpg")
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            try! UIImageJPEGRepresentation(pickedImage, 1.0)?.write(to: imagePath!)
        }
        
        imageString = imagePath?.absoluteString
        print("Image path: \(imageString!)")
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func noCamera() {
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

