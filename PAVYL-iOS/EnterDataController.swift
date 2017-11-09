//
//  EnterDataController.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation
import UIKit

class EnterDataController : UIViewController
{
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var boroughField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    
    @IBAction func onAddPressed(_ sender: Any) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy hh:mm:ss a"
        
        var dataMap = [String: String]()
        
        dataMap["date"] = format.string(from: date)
        dataMap["location"] = locationField.text!
        dataMap["zip"] = zipField.text!
        dataMap["address"] = addressField.text!
        dataMap["city"] = cityField.text!
        dataMap["borough"] = boroughField.text!
        dataMap["latitude"] = latitudeField.text!
        dataMap["longitude"] = longitudeField.text!
        
        let ret = RatData()
        ret.data = dataMap
        
        DataHandler.addData(data: ret, responseHandler: {(response) in ()})
    }
}
