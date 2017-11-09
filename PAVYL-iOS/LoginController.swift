//
//  LoginController.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation
import UIKit

class LoginController : UIViewController
{
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func onLoginPressed(_ sender: Any) {
        if usernameField.hasText && passwordField.hasText {
            spinner.startAnimating()
            
            AuthHandler.login(username: usernameField.text!, password: passwordField.text!, responseHandler: {(response) in
                self.spinner.stopAnimating()
                if response.accept {
                    let menu:UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigation") as! UINavigationController
                    
                    self.present(menu, animated: true, completion: nil)
                }
                else {
                    displayAlert(self, title: "Warning", msg: response.message, action: nil)
                }
            })
        }
    }
    
    @IBAction func onCancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

func displayAlert(_ controller:UIViewController, title:String, msg:String, action:((UIAlertAction?) -> Void)?)
{
    let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: action)
    
    alertController.addAction(okAction)
    
    controller.present(alertController, animated: true, completion: nil)
}
