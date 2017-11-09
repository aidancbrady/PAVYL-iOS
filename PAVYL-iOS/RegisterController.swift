//
//  RegisterController.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation
import UIKit

class RegisterController : UIViewController
{
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var adminSwitch: UISwitch!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func onRegisterPressed(_ sender: Any) {
        if usernameField.hasText && passwordField.hasText && confirmField.hasText {
            if usernameField.text!.count <= Constants.MAX_USERNAME_LENGTH {
                if passwordField.text! == confirmField.text! {
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
                else {
                    displayAlert(self, title: "Warning", msg: "Passwords don't match", action: nil)
                }
            }
            else {
                displayAlert(self, title: "Warning", msg: "Password is too long", action: nil)
            }
        }
    }
    
    @IBAction func onCancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
