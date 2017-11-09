//
//  DataHandler.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation

class DataHandler
{
    class func requestData(limit:Int, offset:Int, responseHandler:@escaping (_ response:Response) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let ret = NetHandler.sendData(compileMsg("GETDATA", String(limit), String(offset)))
            
            DispatchQueue.main.async {
                if let received = ret {
                    let split = received.components(separatedBy: Constants.SPLITTER)
                    
                    if split[0] == "ACCEPT" {
                        let response = Response(accept: true, message: "")
                        response.data = split
                        responseHandler(response)
                    }
                    else {
                        responseHandler(Response(accept: false, message: split[1]))
                    }
                }
            }
        }
    }
    
    class func requestDataInRange(startDate:Date, endDate:Date, responseHandler:@escaping (_ response:Response) -> ()) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        DispatchQueue.global(qos: .background).async {
            let ret = NetHandler.sendData(compileMsg("GETRANGE", formatter.string(from: startDate), formatter.string(from: endDate)))
            
            DispatchQueue.main.async {
                if let received = ret {
                    let split = received.components(separatedBy: Constants.SPLITTER)
                    
                    if split[0] == "ACCEPT" {
                        let response = Response(accept: true, message: "")
                        response.data = split
                        responseHandler(response)
                    }
                    else {
                        responseHandler(Response(accept: false, message: split[1]))
                    }
                }
            }
        }
    }
    
    class func requestMonthlyChartData(startDate:Date, endDate:Date, responseHandler:@escaping (_ response:Response) -> ()) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        DispatchQueue.global(qos: .background).async {
            let ret = NetHandler.sendData(compileMsg("MGRAPH", formatter.string(from: startDate), formatter.string(from: endDate)))
            
            DispatchQueue.main.async {
                if let received = ret {
                    let split = received.components(separatedBy: Constants.SPLITTER)
                    
                    if split[0] == "ACCEPT" {
                        let response = Response(accept: true, message: "")
                        response.data = split
                        responseHandler(response)
                    }
                    else {
                        responseHandler(Response(accept: false, message: split[1]))
                    }
                }
            }
        }
    }
    
    class func addData(data:RatData, responseHandler:@escaping (_ response:Response) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let ret = NetHandler.sendData(compileMsg("ADDDATA", data.compileNoKey()))
            
            DispatchQueue.main.async {
                if let received = ret {
                    let split = received.components(separatedBy: Constants.SPLITTER)
                    
                    if split[0] == "ACCEPT" {
                        responseHandler(Response.ACCEPT)
                    }
                    else {
                        responseHandler(Response(accept: false, message: split[1]))
                    }
                }
            }
        }
    }
}
