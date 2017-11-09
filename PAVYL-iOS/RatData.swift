//
//  RatData.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation

class RatData
{
    var data:[String : String] = [String : String]()
    
    func compile() -> String {
        return data[Constants.DATA_KEY_ID]! + Constants.DATA_SPLIT + compileNoKey()
    }
    
    func compileNoKey() -> String {
        var str = ""
        
        for i in 0..<Constants.DATA_FIELDS.count {
            str += data[Constants.DATA_FIELDS[i]]!
            
            if i < Constants.DATA_FIELDS.count - 1 {
                str += Constants.DATA_SPLIT
            }
        }
        
        return str
    }
    
    static func parse(s:String) -> RatData?
    {
        let data = s.dropFirst().dropLast()
        let split = data.components(separatedBy: Constants.DATA_SPLIT)
        
        if split.count != 9 {
            return nil
        }
        
        var newData:[String : String] = [String : String]()
        newData[Constants.DATA_KEY_ID] = split[0]
        
        for i in 0..<Constants.DATA_FIELDS.count {
            newData[Constants.DATA_FIELDS[i]] = split[i+1]
        }
        
        let ret = RatData()
        ret.data = newData
        
        return ret
    }
}
