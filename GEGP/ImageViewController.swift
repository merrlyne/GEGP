//
//  ImageViewController.swift
//  GEGP
//
//  Created by Eric Fry on 4/26/17.
//  Copyright © 2017 Eric Fry. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, URLSessionDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageURL: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let url = NSURL(string: imageURL!){
            if let data = NSData(contentsOf: url as URL) {
                
                imageView.image = UIImage(data: data as Data)
                imageView.contentMode = .scaleAspectFit
                
                print("\(String(describing: title!)): \(String(describing: imageURL))")
            }        
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
