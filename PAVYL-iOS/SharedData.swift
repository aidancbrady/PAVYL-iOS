//
//  SharedData.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation

struct Constants
{
    //Server data
    static let SERVER_IP:String = "104.236.13.142"
    static let SERVER_PORT:Int = 29421
    
    //CSV splitters
    static let SPLITTER:String = "%1%"
    static let DATA_SPLIT:String = ","
    
    static let MAX_USERNAME_LENGTH:Int = 32
    
    static let DATA_FIELDS:[String] = ["date", "location", "zip", "address", "city", "borough", "latitude", "longitude"]
    static let DATA_KEY_ID:String = "data_key"
}

struct Session
{
    static var username:String = ""
    static var extraData:[String: String] = [String: String]()
    
    static func loadExtraData(s:String)
    {
        let split = s.components(separatedBy: Constants.DATA_SPLIT)
        
        for dataPair in split
        {
            let data = dataPair.components(separatedBy: "=")
            extraData[data[0]] = data[1]
        }
    }
    
    static func reset()
    {
        username = ""
        extraData.removeAll()
    }
}
