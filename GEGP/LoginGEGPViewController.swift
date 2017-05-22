//
//  LoginGEGPViewController.swift
//  GEGP
//
//  Created by Eric Fry on 3/9/17.
//  Copyright © 2017 Eric Fry. All rights reserved.
//
import UIKit

class LoginGEGPViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        if username == "" || password == "" {
            return
        }
        
        //doLogin(user: username!, pswd: password!)
    }
    
    //func doLogin(user: String, pswd: String) {
    //let url = URL(string: "")
//        let session = URLSession.shared
//        
//        let request = NSMutableURLRequest(url: url!)
//        
//        request.httpMethod = "Post"
//        let paramToSend = "username=" + user + "&password=" + pswd
//        
//        request.httpBody = paramToSend.data(using: .utf8)
//        
//        let task = session.dataTask(with: request) { (data, respponse, error) in
//            guard let index:Data = Data else
//            {
//                return
//            }
//        }
    //}
}

