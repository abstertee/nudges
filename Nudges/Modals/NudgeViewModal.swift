//
//  NudgeViewModal.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation
import Cocoa

class NudgeViewModel {
    
    var nudgeDimissalCountReached:Bool = false
    lazy var companyLogo = getCompanyLogo()
    
    func dismissalCounter() -> Bool {
        if globalvars.dismissalCount < globalvars.dismissalThreshold {
            return false
        } else {
            return true
        }
    }
    
    var cutOffWarn: Bool {
        if Dates().daysRemaining < nudgePreferences.cut_off_date_warning {
            return true
        } else {
            return false
        }
    }
    
    func daysRemainingCalc() -> Int {
        if Dates().daysRemaining < 0 {
            return 0
        } else {
            return Dates().daysRemaining
        }
    }
    
    func getCompanyLogo() -> NSImage? {
        if FileManager.default.fileExists(atPath: nudgePreferences.logo_path) {
            return NSImage(byReferencingFile: nudgePreferences.logo_path)
        } else {
            return NSImage(named: "company_logo")
        }
    }
    
    func getScreenShot() -> NSImage? {
        if FileManager.default.fileExists(atPath: nudgePreferences.screenshot_path) {
            return NSImage(byReferencingFile: nudgePreferences.screenshot_path)
        } else {
            return NSImage(named: "screenshot")
        }
    }
    
    
    func fullyUpdated() -> Bool {
        let osVersion = "\(systemInfo.majorOs).\(systemInfo.minorOs).\(systemInfo.patchOs)"
        let versionCompare = osVersion.compare(nudgePreferences.minimum_os_version, options: .numeric)
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
    
    deinit {
        print("NudgeViewModal deinitialized")
    }
    
}
var nudgeViewModel = NudgeViewModel()

