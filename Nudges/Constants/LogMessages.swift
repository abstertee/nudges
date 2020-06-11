//
//  LogMessages.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation

struct LogMessage {
    struct JsonError {
        static let jsonReadError = "Could not read the json file at \(AppFiles.nudgePathJson)"
        static let jsonReadSuccess = "Successfully read json data from settings file."
        static let errorWindowMessage = "\(JsonError.jsonReadError).  Exiting application."
        static let errorReadingConfig = "ERROR Reading Config File"
        static let errorReadingConfigMessage = "There was an error reading the config file so the app will not run properly."
    }
    struct State {
        static let notActive = "Nudge or acceptable applications not currently active."
        static let activate = "Nudge not active - activating to the foreground."
        static let loaded = "Nudge already running and is loaded"
        static let windowClosed = "Nudge window was closed"
        
        static let dismissedCountHigh = "Nudge dismissed count over threshold: "
        static let dismissedCountLow = "Nudge dismissed count under threshold: "
        static let enforcing = "Enforcing acceptable applications"
    }
    
    struct ButtonActions {
        static let buttonMoreInfo = "User clicked on more info button - opening URL in default browser"
        static let updateSimulated = "Simulated click on update button - opening update application"
        static let updateButton = "User clicked on update button - opening update application"
        static let buttonDefer = "User clicked on the defer button - prompting understand window"
        static let buttonUnderstood = "User clicked on understand button - closing window"
        
        static let understoodMessage = """
        The upgrade will be enforced once the days remaining reaches 0.

        At that time, your system will be updated without any notification.

        Please upgrade today to ensure your work is not interrupted.
        """
        
    }
    
    struct Version {
        static let targetOsVersion = "Target OS Version: "
        static let targetOsSubVersion = "Target OS subversion: "
        static let subBuildHigh = "OS version sub build is higher or equal to the minimum threshold: "
        static let subBuildLow = "OS version is below the minimum threshold subversion: "
        static let osBuildHigh = "OS version is higher or equal to the minimum threshold: "
        static let osBuildLow = "OS version is below the minimum threshold: "
    }
    
    struct ApplicationFiles {
        static let jsonFileMissing = "Json File did not exist.  Json file must be placed at \(AppFiles.nudgePathJson.path).  Prompting user and exiting."
        static let alertMessage = "A critical settings file was not found.\n\nPlease contact you HelpDesk Department for assistance."
        static let jsonFileExists = "Successfully found the json settings file."
        static let pathToAppMissing = "Missing the pathtoapp entry in the Json File.  This should be the path to the OS Update app."
    }
    
    struct Timer {
        static let noTimerActive = "No timer active, start the timer before you stop it."
        static let running = "Timer already running and initialized."
    }
    
}

