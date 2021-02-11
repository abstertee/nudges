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
    // Check if the system is fully updated to the minimum version
    // from the JSON pref file.
    if nudgeViewModel.fullyUpdated() {
        //OSLog.log(LogMessage.State.current, log: .info, type: .info)
        logger.write(entry: LogMessage.State.current)
        nudgeViewModel.quitApp()
    }
    var frontMostApp: String = ""
    if let fma = globalvars.workspace.frontmostApplication?.bundleIdentifier {
        frontMostApp = fma
    }
    
    print("Is my window loaded: \(nudgewindow.isOpen)")
    //OSLog.log("Is my window loaded: \(nudgewindow.isOpen)", log: .info, type: .info)
    logger.write(entry: "Is my window loaded: \(nudgewindow.isOpen)")
    let currentlyActive = NSApplication.shared.isActive
    //print(frontMostApp)
    //OSLog.log("The frontmost app is: \(frontMostApp)", log: .info, type: .info)
    logger.write(entry: "The frontmost app is: \(frontMostApp)")
    logger.write(entry: "Nudges is currently active: \(currentlyActive)")
    print("Nudges is currently active: \(currentlyActive)")
    //OSLog.log("Nudges is currently active: \(currentlyActive)", log: .info, type: .info)
    
    print(globalvars.acceptableApps.contains(frontMostApp))
    
    if currentlyActive || globalvars.acceptableApps.contains(frontMostApp) { //&& nudgewindow.isOpen {
        // App is running and it's the front most app, so exit function
        print(LogMessage.State.loaded)
        logger.write(entry: LogMessage.State.loaded)
        //OSLog.log(LogMessage.State.loaded, log: .info, type: .info)
        //bringNudgeToForeFront()
        return
    }
    OSLog.log(LogMessage.State.notActive + " \(frontMostApp)", log: .info, type: .info)
    if globalvars.dismissalCount < globalvars.dismissalThreshold {
        print(LogMessage.State.dismissedCountLow + globalvars.dismissalCount.description)
        logger.write(entry: LogMessage.State.dismissedCountLow + globalvars.dismissalCount.description)
        //OSLog.log(LogMessage.State.dismissedCountLow + globalvars.dismissalCount.description, log: OSLog.info, type: .info)
        //globalvars.dismissalCount += 1
        bringNudgeToForeFront()
    }
    else {
        // Dismissal count has reached threshold
        print(LogMessage.State.dismissedCountHigh + globalvars.dismissalCount.description)
        //OSLog.log(LogMessage.State.dismissedCountHigh + globalvars.dismissalCount.description, log: OSLog.info, type: .info)
        logger.write(entry: LogMessage.State.dismissedCountHigh + globalvars.dismissalCount.description)
        //globalvars.dismissalCount += 1
        OSLog.log(LogMessage.State.enforcing, log: OSLog.info, type: .info)
        logger.write(entry: LogMessage.State.enforcing)
        for app in NSWorkspace.shared.runningApplications {
            if let appName = app.localizedName, let appBundle = app.bundleURL {
                if appBundle.path == nudgePreferences.preferences.path_to_app {
                    globalvars.acceptableApps.append(appName)
                }
                if globalvars.acceptableApps.contains(appName) == false || appBundle.path != nudgePreferences.preferences.path_to_app {
                    app.hide()
                }
            }
        }
        bringNudgeToForeFront()
    }

}


func bringNudgeToForeFront() {
    if nudgewindow.myWindow?.isVisible != nil && nudgewindow.myWindow?.isVisible == true {
        print("Nudges visible is not nill and is true")
        windowWillClose()
    }
    print("Launching Window")
    //OSLog.log("Launching Nudge Window", log: OSLog.view, type: .info)
    logger.write(entry: "Launching Nudge Window")
    if nudgewindow.myWindow?.isVisible == false || nudgewindow.myWindow?.isVisible == nil {
        nudgewindow.launchWindow()
    }
    NSApplication.shared.activate(ignoringOtherApps: true)
    nudgewindow.myWindow?.makeKeyAndOrderFront(nil)
    nudgewindow.myWindow?.level = .floating
    //OSLog.log("Is my window loaded: \(nudgewindow.isOpen)", log: .info, type: .info)
    logger.write(entry: "Is my window loaded: \(nudgewindow.isOpen)")
}


func windowWillClose() {
    guard let win = nudgewindow.myWindow else {
        return
    }
    if win.isModalPanel {
        NSApp.abortModal()
    }
    if let sheetParent = win.sheetParent {
        sheetParent.endSheet(win)
    }
    win.close()
    nudgewindow.myWindow?.close()
    nudgewindow = WindowManager()
}

func getAppToLaunch() -> URL {
    if nudgePreferences.preferences.local_url_for_upgrade.isEmpty {
        //OSLog.log(LogMessage.General.localAppPath + nudgePreferences.path_to_app, log: .info, type: .info)
        logger.write(entry: LogMessage.General.localAppPath + nudgePreferences.preferences.path_to_app)
        return URL(fileURLWithPath: nudgePreferences.preferences.path_to_app)
    }
    //OSLog.log(LogMessage.General.localAppPath + nudgePreferences.local_url_for_upgrade, log: .info, type: .info)
    logger.write(entry: LogMessage.General.localAppPath + nudgePreferences.preferences.local_url_for_upgrade)
    guard let url = URL(string: nudgePreferences.preferences.local_url_for_upgrade) else {
        return URL(fileURLWithPath: nudgePreferences.preferences.local_url_for_upgrade)
    }
    return url
}
