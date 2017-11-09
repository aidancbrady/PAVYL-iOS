//
//  GraphController.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation
import UIKit
import Charts

class GraphController : UIViewController
{
    @IBOutlet weak var graph: BarChartView!
    
    var fromDate:Date!
    var toDate:Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graph.noDataText = "Computing..."
        graph.chartDescription!.text = ""
        graph.doubleTapToZoomEnabled = false
        graph.pinchZoomEnabled = false
        graph.xAxis.drawGridLinesEnabled = false
        graph.leftAxis.axisMinimum = 0.0
        graph.rightAxis.axisMinimum = 0.0
        
        DataHandler.requestMonthlyChartData(startDate: fromDate, endDate: toDate, responseHandler: {(response) in
            if response.accept {
                let data = response.data[1].components(separatedBy: Constants.DATA_SPLIT)
                var dataEntries:[BarChartDataEntry] = [BarChartDataEntry]()
                
                for i in 0..<data.count {
                    print(String(i) + " " + data[i])
                    dataEntries.append(BarChartDataEntry(x: Double(i), y: Double(data[i])!))
                }
                
                let chartDataSet = BarChartDataSet(values: dataEntries, label: "Rat Sightings")
                let chartData = BarChartData(dataSet: chartDataSet)
                self.graph.data = chartData
                self.graph.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
            }
        })
    }
}
