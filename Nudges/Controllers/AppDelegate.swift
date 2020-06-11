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
        sleep(UInt32(2.0))
        // If no timer value is true
        // then show window once on launch
        if nudgePreferences.no_timer {
            determineStateAndNudge()
        } else{
            GlobalTimer.sharedTimer.startTimer(andJob: determineStateAndNudge)
        }
        
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
        Alerts.shared.alertMessage(nil, messageText, "Ok", nil, infoText, .window)
        //exit(1)
    }


}
