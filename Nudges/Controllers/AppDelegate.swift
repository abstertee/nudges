//
//  AppDelegate.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Cocoa
import os.log

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if settingsFileExist() == false {
            alertNoSettingsFile()
            return
        }
        NSApp.setActivationPolicy(.accessory)
        //nudgewindow.launchWindow()
        GlobalTimer.sharedTimer.startTimer(andJob: determineStateAndNudge)
        
    }
    
    
    func settingsFileExist() -> Bool {
        if FileManager.default.fileExists(atPath: AppFiles.nudgePathJson.path) {
            OSLog.log(LogMessage.ApplicationFiles.jsonFileExists, log: OSLog.info, type: .info)
            return true
        }
        return false
    }
    
    func alertNoSettingsFile() {
        let messageText = "ERROR!"
        let infoText = LogMessage.ApplicationFiles.alertMessage
        Alerts().alertMessage(currentWindow: nil, messageText: messageText, mainButton: "Ok", additionalButton: "", informativeText: infoText, windowType: .window)
        //exit(1)
    }


}

