//
//  Nudge.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/27/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation
import Cocoa
import os

func determineStateAndNudge() {
    //print("running determine state and nudge")
    let frontMostApp = globalvars.workspace.frontmostApplication?.bundleIdentifier
    //print(frontMostApp)
    let currentlyActive = NSApplication.shared.isActive
    //print(currentlyActive)
    if currentlyActive == false && globalvars.acceptableApps.contains(frontMostApp!) == false {
        //print("\(frontMostApp) is active")
        OSLog.log(LogMessage.State.notActive, log: OSLog.error, type: .info)
        //print("Dismissal Count is \(globalvars.dismissalCount)")
        if globalvars.dismissalCount < globalvars.dismissalThreshold {
            OSLog.log(LogMessage.State.dismissedCountLow + globalvars.dismissalCount.description, log: OSLog.info, type: .info)
            globalvars.dismissalCount += 1
            bringNudgeToForeFront()
        }
        else {
            // Dismissal count has reached threshold
            OSLog.log(LogMessage.State.dismissedCountHigh + globalvars.dismissalCount.description, log: OSLog.info, type: .info)
            globalvars.dismissalCount += 1
            OSLog.log(LogMessage.State.enforcing, log: OSLog.info, type: .info)
            for app in NSWorkspace.shared.runningApplications {
                let appName = app.localizedName
                let appBundle = app.bundleURL
                if appBundle!.path == nudgePreferences.path_to_app {
                    globalvars.acceptableApps.append(appName!)
                }
                
                if globalvars.acceptableApps.contains(appName!) == false || appBundle!.path != nudgePreferences.path_to_app {
                    app.hide()
                    sleep(UInt32(0.1))
                }
            }
            sleep(UInt32(0.5))
            bringNudgeToForeFront()
        }
    }
}


func bringNudgeToForeFront() {
    nudgewindow.myWindow?.close()
    //print("Launching Window")
    //print("NudgeWindow is visible: \(nudgewindow.myWindow?.isVisible ?? false)")
    OSLog.log("Launching Nudge Window", log: OSLog.view, type: .info)
    if nudgewindow.myWindow?.isVisible == false || nudgewindow.myWindow?.isVisible == nil {
        nudgewindow.launchWindow()
    }
    NSApplication.shared.activate(ignoringOtherApps: true)
    nudgewindow.myWindow?.makeKeyAndOrderFront(nil)
    nudgewindow.myWindow?.level = .floating
}


