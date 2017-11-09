//
//  WelcomeController.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation
import UIKit

class MainController : UIViewController
{
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = Session.username
        
        let admin = Session.extraData["admin"]! == "true"
        statusLabel.text = "Status: " + (admin ? "Admin" : "User")
    }
    
    @IBAction func onGraphPressed(_ sender: Any) {
        let dateController:ChooseDateController = storyboard?.instantiateViewController(withIdentifier: "ChooseDateController") as! ChooseDateController
        dateController.isMap = false
        navigationController!.pushViewController(dateController, animated: true)
    }
    
    @IBAction func onMapPressed(_ sender: Any) {
        let dateController:ChooseDateController = storyboard?.instantiateViewController(withIdentifier: "ChooseDateController") as! ChooseDateController
        dateController.isMap = true
        navigationController!.pushViewController(dateController, animated: true)
    }
    
    @IBAction func onViewDataPressed(_ sender: Any) {
    }
    
    @IBAction func onEnterSightingPressed(_ sender: Any) {
    }
    
    @IBAction func onLogoutPressed(_ sender: Any) {
        Session.reset()
        navigationController!.dismiss(animated: true, completion: nil)
    }
}
