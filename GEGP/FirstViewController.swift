//
//  FirstViewController.swift
//  GEGP
//
//  Created by Eric Fry on 3/1/17.
//  Copyright © 2017 Eric Fry. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FirstViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var lblLoginStatus: UILabel!
    @IBOutlet weak var profilePictureView: FBSDKProfilePictureView!
    @IBOutlet weak var FBloginButton: FBSDKLoginButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var CreateAccountButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FBSDKAccessToken.current() != nil {
            FBloginButton.readPermissions = ["public_profile", "email"]
            FBloginButton.delegate = self
            CreateAccountButton.isHidden = true
            self.setLabels()
        }
        else {
            self.profilePictureView.isHidden = true
            self.lblLoginStatus.text = "Please Login or Create an Account"
            self.lblEmail.text = ""
            self.lblUserName.text = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
        self.profilePictureView.isHidden = true
        CreateAccountButton.isHidden = false
        self.lblLoginStatus.text = "Please Login or Create an Account"
        self.lblEmail.text = ""
        self.lblUserName.text = ""
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        setLabels()
        print("Successfully logged in with facebook...")
        
    }
    
    func setLabels() {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start {
            (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err!)
                return
            }
            let data:[String:AnyObject] = result as! [String : AnyObject]
            
            
            let name : NSString? = data["name"]! as? NSString
            let email : NSString? = data["email"]! as? NSString
            
            self.profilePictureView.isHidden = false
            self.lblLoginStatus.text = "Successfully Logged In"
            self.lblEmail.text = email as String?
            self.lblUserName.text = name as String?
            
            print(result!)
        }
    }
}




















