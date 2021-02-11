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
        //print("reading json file: \(jsonFile.path)")
        self.jsonFile = jsonFile
        self.jsonData = getJsonData(jsonFile)
    }
    
    private func getJsonData(_ jsonFile: URL) -> Data {
        //print("getting json data...")
        //let tempData = Data()
        do {
            let myData = try Data(contentsOf: jsonFile, options: .dataReadingMapped)
            print(myData)
            if myData.isEmpty {
                print(LogMessage.JsonError.jsonReadError)
                //OSLog.log(LogMessage.JsonError.jsonReadError, log: OSLog.error, type: .error)
                logger.write(entry: LogMessage.JsonError.jsonReadError)
                return Data()
            }
            return myData
        }
        catch {
            print(error)
            let myAlert = Alerts(currentWindow: nil, messageText: LogMessage.JsonError.errorReadingConfig, mainButton: "Ok", additionalButton: nil, informativeText: LogMessage.JsonError.errorReadingConfigMessage, windowType: .window)
            myAlert.alert.runModal()
            exit(202)
            //Alerts.shared.alertMessage(nil, LogMessage.JsonError.errorReadingConfig, "Ok", nil, LogMessage.JsonError.errorReadingConfigMessage, .window)
        }
        //return Data()
    }
    
    private func createJsonStructs(_ jsonData: Data) -> Void {
        let decodedData = try? JSONDecoder().decode(NudgePrefs.self, from: jsonData)
        guard decodedData != nil else {
            return
        }
        debugPrint(decodedData.debugDescription)
        //OSLog.log(LogMessage.JsonError.jsonReadSuccess, log: OSLog.info, type: .info)
        logger.write(entry: LogMessage.JsonError.jsonReadSuccess)
        return
    }

}
