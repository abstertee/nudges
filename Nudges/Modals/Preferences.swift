//
//  Preferences.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation
import os

struct AppFiles {
    // Folders
    static let nudgePath = FileManager.default.urls(for: .libraryDirectory, in: .localDomainMask)[0].appendingPathComponent("nudges")
    static let nudgePathResources = nudgePath.appendingPathComponent("Resources")
    
    // Files
    static let nudgePathJson = AppFiles.nudgePathResources.appendingPathComponent("nudges.json")
}

struct NudgePrefs: Decodable {
//    var preferences: PreferencesKey?
//    var osVersionRequirements: OsVersionRequirementKeys?
//    var userInterface: UserInterface?
//    var timer: Timer?
    let preferences: Preferences
    let userInterface: UserInterface
    let osVersionRequirements: OsVersionRequirement
    let timer: Timer
    
    struct Preferences: Decodable {
        let cut_off_date: String
        let cut_off_date_warning: Int
        let days_between_notifications: Int
        let defer_menu: Bool
        let defer_options: [DeferOptions]
        let dismissal_count_threshold: Int
        let logo_path: String
        let local_url_for_upgrade: String
        
        let path_to_app: String
        let random_delay: String
        
        struct DeferOptions: Decodable {
            let seconds: Int
            let text: String
        }
    }
    
    struct UserInterface: Decodable {
        let button_title_text: String
        let button_sub_titletext: String
        let defer_message: String
        let defer_heading: String
        let defer_text: String
        let main_subtitle_text: String
        let main_title_text: String
        let more_info_url: URL
        let paragraph1_text: String
        let paragraph2_text: String
        let paragraph3_text: String
        let paragraph_title_text: String
        let screenshot_path: String
    }
    
    struct OsVersionRequirement: Decodable {
        let minimum_os_sub_build_version: String
        let minimum_os_version: String
        let update_minor: String
        let update_minor_days: Int
        
    }
    
    struct Timer: Decodable {
        let timer_day_1: Int
        let timer_day_3: Int
        let timer_elapsed: Int
        let timer_final: Int
        let timer_initial: Int
        let no_timer: Bool
    }
    
}


var nudgePreferencesRaw: NudgePrefs? = setPreferences()
let nudgePreferences = nudgePreferencesRaw!

func getPrefs() -> NudgePrefs {
    guard let prefs = nudgePreferencesRaw else {
        let messageText = "ERROR Reading Config file."
        let infoText = "There was an error reading the config file so the app will not run properly."
        let myAlert = Alerts(currentWindow: nil, messageText: messageText, mainButton: "Ok", additionalButton: nil, informativeText: infoText, windowType: .window)
        //Alerts.shared.alertMessage(nil, messageText, "Ok", nil, infoText, .window)
        myAlert.alert.runModal()
        exit(101)
        //return
    }
    //print("returning prefs: \(prefs.preferences)")
    return prefs
}

func setPreferences() -> NudgePrefs? {
    print("Running setPrefs...")
    do {
        let fileData = try JSONDecoder().decode(NudgePrefs.self, from: JsonReader(jsonFile: AppFiles.nudgePathJson).jsonData)
        debugPrint("File data is: \(fileData)")
        return fileData
    } catch {
        //OSLog.log(LogMessage.JsonError.jsonReadError + "\(error)", log: OSLog.error, type: .error)
        logger.write(entry: LogMessage.JsonError.jsonReadError + "\(error)")
        print(LogMessage.JsonError.jsonReadError + "\(error)")
        return nil
    }
}


