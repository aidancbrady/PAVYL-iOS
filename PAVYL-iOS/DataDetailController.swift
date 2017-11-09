//
//  DataDetailController.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation
import UIKit

class DataDetailController : UIViewController
{
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var boroughLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    var data:RatData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyLabel.text = "Key: " + data.data["data_key"]!
        dateLabel.text = "Date: " + data.data["date"]!
        locationLabel.text = "Location: " + data.data["location"]!
        zipLabel.text = "Zip: " + data.data["zip"]!
        addressLabel.text = "Address: " + data.data["address"]!
        cityLabel.text = "City: " + data.data["city"]!
        boroughLabel.text = "Borough: " + data.data["borough"]!
        latitudeLabel.text = "Latitude: " + data.data["latitude"]!
        longitudeLabel.text = "Longitude: " + data.data["longitude"]!
    }
}
