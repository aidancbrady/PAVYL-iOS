//
//  RatDataListController.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation
import UIKit

class RatDataListController : UITableViewController
{
    var dataList:[RatData] = [RatData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataHandler.requestData(limit: 100, offset: 0, responseHandler: {(response) in
            if response.accept {
                let data = response.data
                
                for i in 1..<data.count {
                    let ret = RatData.parse(s: data[i])
                    
                    if let newData = ret {
                        self.dataList.append(newData)
                    }
                }
                
                self.tableView.reloadData()
            }
        })
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let lastVisiblePath = tableView.indexPathsForVisibleRows!.last!
        let newIndex = lastVisiblePath.row+1
        
        if newIndex == dataList.count {
            DataHandler.requestData(limit: 100, offset: newIndex, responseHandler: {(response) in
                if response.accept {
                    let data = response.data
                    
                    for i in 1..<data.count {
                        let ret = RatData.parse(s: data[i])
                        
                        if let newData = ret {
                            self.dataList.append(newData)
                        }
                    }
                    
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:RatSightingCell = tableView.dequeueReusableCell(withIdentifier: "RatSighting", for: indexPath) as! RatSightingCell
        let data:RatData = dataList[indexPath.row]
   
        cell.dateLabel.text = data.data["date"]
        cell.keyLabel.text = data.data["data_key"]
        
        cell.data = data
        cell.controller = self
        
        return cell
    }
}

class RatSightingCell : UITableViewCell
{
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    
    var data: RatData!
    var controller:UITableViewController!
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        if selected
        {
            let detail:DataDetailController = controller!.storyboard?.instantiateViewController(withIdentifier: "DataDetailController") as! DataDetailController
            detail.data = data
            controller!.navigationController!.pushViewController(detail, animated: true)
        }
    }
}
