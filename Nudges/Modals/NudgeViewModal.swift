//
//  NudgeViewModal.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation
import Cocoa

var nudgeViewModel = NudgeViewModel()
class NudgeViewModel {
    static let shared = NudgeViewModel()
    var dates = Dates()
    var enforceUpdate: Bool = false
    var nudgeDimissalCountReached:Bool = false
    lazy var companyLogo = getCompanyLogo()
    lazy var enforce: Bool = enforcementCheck()
    
    var cutOffDate: String {
        return dates.cutOffDatePretty
    }
    init() {
        print("NudgeViewModel Initialized")
        
    }
    var cutOffWarn: Bool {
        if dates.daysRemaining < nudgePreferences.preferences.cut_off_date_warning {
            return true
        } else {
            return false
        }
    }
    
    deinit {
        print("NudgeViewModal deinitialized")
    }
}
    
extension NudgeViewModel {
    func enforcementCheck() -> Bool {
        if dates.secondsRemaining < 0 {
            print("Enforce Return is True")
            return true
        } else {
            print("Enforce Return is False")
            return false
        }
    }
    
    func dismissalCounter() -> Bool {
        if globalvars.dismissalCount < globalvars.dismissalThreshold {
            return false
        } else {
            return true
        }
    }
    
    func daysRemainingCalc() -> Int {
        //OSLog.log("Days Remaining until enforcement: \(dates.daysRemaining)", log: .info, type: .info)
        logger.write(entry: "Days Remaining until enforcement: \(dates.daysRemaining)")
        if dates.daysRemaining < 0 {
            return 0
        } else {
            return dates.daysRemaining
        }
    }

}

extension NudgeViewModel {
    
    func getCompanyLogo() -> NSImage? {
        if FileManager.default.fileExists(atPath: nudgePreferences.preferences.logo_path) {
            return NSImage(byReferencingFile: nudgePreferences.preferences.logo_path)
        } else {
            return NSImage(named: "company_logo")
        }
    }
    
    func getScreenShot() -> NSImage? {
        if FileManager.default.fileExists(atPath: nudgePreferences.userInterface.screenshot_path) {
            return NSImage(byReferencingFile: nudgePreferences.userInterface.screenshot_path)
        } else {
            return NSImage(named: "screenshot")
        }
    }
    
    func appUpgradePath() -> URL {
        if nudgePreferences.preferences.local_url_for_upgrade.isEmpty == false {
            return URL(string: nudgePreferences.preferences.local_url_for_upgrade)!
        }
        if nudgePreferences.preferences.path_to_app.isEmpty {
            //OSLog.log(LogMessage.ApplicationFiles.pathToAppMissing, log: OSLog.error, type: .error)
            logger.write(entry: LogMessage.ApplicationFiles.pathToAppMissing)
        }
        if FileManager.default.fileExists(atPath: nudgePreferences.preferences.path_to_app) {
            return URL(string: nudgePreferences.preferences.path_to_app)!
        }
        let myAlert = Alerts(currentWindow: nil, messageText: "Uh Oh!", mainButton: "Ok", additionalButton: nil, informativeText: LogMessage.ApplicationFiles.pathToAppMissing, windowType: .window)
        myAlert.alert.runModal()
        //Alerts.shared.alertMessage(nil, "Uh Oh!", "Ok", nil, LogMessage.ApplicationFiles.pathToAppMissing, .window)
        return URL(string: "https://www.workday.com")!
    }
    
    func launchUrl(_ url:URL) {
        do {
            try NSWorkspace.shared.open(url)
        } catch {
            print(error)
            //OSLog.log(LogMessage.ButtonActions.buttonUpdateFail + error.localizedDescription, log: .info, type: .info)
            logger.write(entry: LogMessage.ButtonActions.buttonUpdateFail + error.localizedDescription)
        }
    }
    
    func launchApp(_ appPath:URL) {
        do {
            try NSWorkspace.shared.launchApplication(at: appPath as URL, options: .andHideOthers, configuration: [:])
        } catch {
            print(error)
            //OSLog.log(LogMessage.ButtonActions.buttonUpdateFail + error.localizedDescription, log: .info, type: .info)
            logger.write(entry: LogMessage.ButtonActions.buttonUpdateFail + error.localizedDescription)
        }
    }
    
    func fullyUpdated() -> Bool {
        let osVersion = "\(systemInfo.majorOs).\(systemInfo.minorOs).\(systemInfo.patchOs)"
        let versionCompare = osVersion.compare(nudgePreferences.osVersionRequirements.minimum_os_version, options: .numeric)
        if versionCompare == .orderedSame {
            // User is up to date
            return true
        } else if versionCompare == .orderedAscending {
            // User must upgrade
            return false
        } else if versionCompare == .orderedDescending {
            // User is up to date
            return true
        }
        return false
    }
    
    func quitApp() {
        NSApplication.shared.terminate(self)
    }
    
}

extension NudgeViewModel {
    func minDeferTime() -> Int {
        var arr:[Int] = []
        for item in nudgePreferences.preferences.defer_options {
            arr.append(item.seconds)
        }
        guard let minValue = arr.min() else {
            return 3600
        }
        return minValue
    }
    
    
    func deferTimeAvailable() -> Int {
        var timeleft: Int
        timeleft = dates.secondsRemaining
        switch timeleft {
        case 1...900:
            print("Less then 15 min")
        case 900..<1800:
            print("Less then 30 min")
        case 1800..<3600:
            print("Less then 1 hour")
        case 3600..<10800:
            print("Less then 3 hours")
        case 10800..<21600:
            print("Less then 6 hours")
        case 21600..<43200:
            print("Less then 12 hours")
        case 43200..<86400:
            print("Less then a day left")
        case 86400 ..< .max :
            print("Still Got Time")
        default:
            print("No More time Left")
        }
        return timeleft
    }
}

