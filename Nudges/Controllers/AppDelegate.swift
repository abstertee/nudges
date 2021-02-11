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
        checkIfRunning()
        if settingsFileExist() == false {
            print(LogMessage.ApplicationFiles.jsonFileMissing)
            OSLog.log(LogMessage.ApplicationFiles.jsonFileMissing, log: .error, type: .error)
            logger.write(entry: LogMessage.ApplicationFiles.jsonFileMissing)
            //exit(100)
        }
        NSApp.setActivationPolicy(.accessory)
        print("Timer Turned On: \(nudgePreferences.timer.no_timer)")
        // If no timer value is true
        // then show window once on launch
        if nudgePreferences.timer.no_timer {
            determineStateAndNudge()
        }
        else{
            print("Timer set to: \(nudgePreferences.timer.timer_initial)")
            globalTimer.startTimer(newLoopTime: nil)
            //determineStateAndNudge()
            //globalTimer.startTimer(andJob: determineStateAndNudge)
        }
    }
    
    func settingsFileExist() -> Bool {
        if FileManager.default.fileExists(atPath: AppFiles.nudgePathJson.path) {
            OSLog.log(LogMessage.ApplicationFiles.jsonFileExists, log: OSLog.info, type: .info)
            logger.write(entry: LogMessage.ApplicationFiles.jsonFileExists)
            return true
        }
        return false
    }
    
    func checkIfRunning() {
        var bundleID: String
        /* Check if another instance of this app is running. */
        if let id = Bundle.main.bundleIdentifier {
            bundleID = id
        } else {
            bundleID = "com.tarent.Nudges"
        }
        if NSRunningApplication.runningApplications(withBundleIdentifier: bundleID).count > 1 {
             /* Activate the other instance and terminate this instance. */
            OSLog.log(LogMessage.State.loaded, log: .info, type: .info)
            logger.write(entry: LogMessage.State.loaded)
            let apps = NSRunningApplication.runningApplications(withBundleIdentifier: bundleID)
            for app in apps {
                if app != NSRunningApplication.current {
                    //print(app.processIdentifier)
                    app.activate(options: [.activateAllWindows, .activateIgnoringOtherApps])
                    //NSApp.terminate(nil)
                    break
                }
            }
            //NSApp.terminate("Terminating app")
        }
    }
}
