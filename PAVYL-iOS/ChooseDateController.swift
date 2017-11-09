//
//  ChooseDateController.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation
import UIKit

class ChooseDateController : UIViewController
{
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    
    var isMap: Bool = true
    
    @IBAction func onContinuePressed(_ sender: Any) {
        let fromDate = fromDatePicker.date
        let toDate = toDatePicker.date
        
        if isMap {
            let mapController:MapController = storyboard?.instantiateViewController(withIdentifier: "MapController") as! MapController
            mapController.fromDate = fromDate
            mapController.toDate = toDate
            navigationController!.pushViewController(mapController, animated: true)
        }
        else {
            let graphController:GraphController = storyboard?.instantiateViewController(withIdentifier: "GraphController") as! GraphController
            graphController.fromDate = fromDate
            graphController.toDate = toDate
            navigationController!.pushViewController(graphController, animated: true)
        }
    }
}
