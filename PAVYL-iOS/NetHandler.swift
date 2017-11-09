//
//  NetHandler.swift
//  VocabCrack
//
//  Created by aidancbrady on 12/2/14.
//  Copyright (c) 2014 aidancbrady. All rights reserved.
//
import Foundation

class NetHandler
{
    @discardableResult
    class func sendData(_ str:String) -> String?
    {
        Operations.setNetworkActivity(true)
        
        var inputStream:InputStream?
        var outputStream:OutputStream?
        
        Stream.getStreamsToHost(withName: Constants.SERVER_IP, port: Constants.SERVER_PORT, inputStream: &inputStream, outputStream: &outputStream)
        
        var writeData = [UInt8]((str + "\n").utf8)
        
        outputStream!.open()
        outputStream!.write(&writeData, maxLength: writeData.count)
        outputStream!.close()
        
        inputStream!.open()
        
        var buffer = [UInt8](repeating: 0, count: 1048576)
        var bytes = inputStream!.read(&buffer, maxLength: 1024)
        let data = NSMutableData(bytes: &buffer, length: bytes)
        
        while inputStream!.hasBytesAvailable
        {
            let read = inputStream!.read(&buffer, maxLength: 1024)
            bytes += read
            data.append(&buffer, length: read)
        }
        
        inputStream?.close()
        
        Operations.setNetworkActivity(false)
        
        if let str = NSString(bytes: data.bytes, length: bytes, encoding: String.Encoding.utf8.rawValue)
        {
            return (str as String).replacingOccurrences(of: "\n", with: "")
        }
        
        return nil
    }
}

func compileMsg(_ msg:String...) -> String
{
    var ret = ""
    
    if msg.count > 0
    {
        for index in 0...msg.count-1
        {
            ret += msg[index]
            
            if index < msg.count-1
            {
                ret += Constants.SPLITTER
            }
        }
    }
    
    return ret
}

class Response
{
    static let ACCEPT:Response = Response(accept: true, message: "")
    static let ERROR:Response = Response(accept: false, message: "Error")
    
    var accept: Bool = false
    var message: String = ""
    var data: [String] = [String]()
    
    init(accept: Bool, message: String) {
        self.accept = accept
        self.message = message
    }
}
