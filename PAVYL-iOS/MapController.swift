//
//  MapController.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapController : UIViewController
{
    @IBOutlet weak var map: MKMapView!
    
    var fromDate:Date!
    var toDate:Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataHandler.requestDataInRange(startDate: fromDate, endDate: toDate, responseHandler: {(response) in
            if response.accept {
                let data = response.data
                
                for i in 1..<data.count {
                    let ret = RatData.parse(s: data[i])
                    
                    if let newData = ret {
                        if let latitude = Double(newData.data["latitude"]!) {
                            if let longitude = Double(newData.data["longitude"]!) {
                                let annotation = MKPointAnnotation()
                                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                annotation.title = newData.data["data_key"]
                                self.map.addAnnotation(annotation)
                            }
                        }
                    }
                }
            }
        })
    }
}
