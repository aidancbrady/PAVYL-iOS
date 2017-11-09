//
//  AuthHandler.swift
//  PAVYL-iOS
//
//  Created by Aidan Brady on 11/8/17.
//  Copyright © 2017 Aidan Brady. All rights reserved.
//

import Foundation

class AuthHandler
{
    class func login(username:String, password:String, responseHandler:@escaping (_ response:Response) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let ret = NetHandler.sendData(compileMsg("AUTH", username, password))
            
            DispatchQueue.main.async {
                if let received = ret {
                    let split = received.components(separatedBy: Constants.SPLITTER)
                    
                    if split[0] == "ACCEPT" {
                        Session.username = username
                        
                        if split.count == 2 {
                            Session.loadExtraData(s: split[1])
                        }
                        
                        responseHandler(Response.ACCEPT)
                    }
                    else {
                        responseHandler(Response(accept: false, message: split[1]))
                    }
                }
            }
        }
    }
    
    class func register(username:String, password:String, extra:String, responseHandler:@escaping (_ response:Response) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let ret = NetHandler.sendData(compileMsg("REGISTER", username, password, extra))
            
            DispatchQueue.main.async {
                if let received = ret {
                    let split = received.components(separatedBy: Constants.SPLITTER)
                    
                    if split[0] == "ACCEPT" {
                        Session.username = username
                        Session.loadExtraData(s: extra)
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
