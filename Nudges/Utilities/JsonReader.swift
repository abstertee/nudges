//
//  JsonReader.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation
import os

class JsonReader {
    var jsonFile: URL
    var jsonData: Data = Data()
    
    init(jsonFile: URL) {
        self.jsonFile = jsonFile
        self.jsonData = getJsonData(jsonFile)
    }
    
    private func getJsonData(_ jsonFile: URL) -> Data {
        let tempData = Data()
        do {
            let myData = try Data(contentsOf: jsonFile, options: .dataReadingMapped)
            if myData.isEmpty {
                OSLog.log(LogMessage.JsonError.jsonReadError, log: OSLog.error, type: .error)
                return tempData
            }
            return myData
        }
        catch {
            print(error)
            Alerts.shared.alertMessage(nil, LogMessage.JsonError.errorReadingConfig, "Ok", nil, LogMessage.JsonError.errorReadingConfigMessage, .window)
            //exit(1)
        }
        return tempData
    }
    
    private func createJsonStructs(_ jsonData: Data) -> Void {
        let decodedData = try? JSONDecoder().decode(JsonRoot.self, from: jsonData)
        guard decodedData != nil else {
            return
        }
        //print(jsondata)
        OSLog.log(LogMessage.JsonError.jsonReadSuccess, log: OSLog.info, type: .info)
        return
    }

}



/*private func getJsonData(_ jsonFile: URL) -> Data {
    let tempData = Data()
    let temp = try? Data(contentsOf: jsonFile, options: .dataReadingMapped)
    guard let decodedData = temp else {
        OSLog.log(LogMessage.JsonError.jsonReadError, log: OSLog.error, type: .error)
        return tempData
    }
    if decodedData.isEmpty {
        OSLog.log(LogMessage.JsonError.jsonReadError, log: OSLog.error, type: .error)
        return tempData
    }
    OSLog.log(LogMessage.JsonError.jsonReadSuccess, log: OSLog.info, type: .info)
    return decodedData
}*/
