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
    static let nudgePathJson = AppFiles.nudgePathResources.appendingPathComponent("nudge.json")
}

struct JsonRoot: Codable {
    let preferences: JsonPreferencesKey
}

struct JsonPreferencesKey: Codable {
    let button_title_text: String
    let button_sub_titletext: String
    let cut_off_date: String
    let cut_off_date_warning: Int
    let days_between_notifications: Int
    let dismissal_count_threshold: Int
    let logo_path: String
    let main_subtitle_text: String
    let main_title_text: String
    let minimum_os_sub_build_version: String
    let minimum_os_version: String
    let more_info_url: URL
    let no_timer: Bool
    let paragraph1_text: String
    let paragraph2_text: String
    let paragraph3_text: String
    let paragraph_title_text: String
    let path_to_app: String
    let random_delay: Bool
    let screenshot_path: String
    let timer_day_1: Int
    let timer_day_3: Int
    let timer_elapsed: Int
    let timer_final: Int
    let timer_initial: Int
    let update_minor: Bool
    let update_minor_days: Int
}


var nudgePreferencesRaw: JsonRoot? = setPreferences()
let nudgePreferences = nudgePreferencesRaw!.preferences

func getPrefs() -> JsonPreferencesKey {
    guard let prefs = nudgePreferencesRaw else {
        let messageText = "ERROR Reading Config file."
        let infoText = "There was an error reading the config file so the app will not run properly."
        Alerts.shared.alertMessage(nil, messageText, "Ok", nil, infoText, .window)
        exit(1)
        //return
    }
    return prefs.preferences
}

func setPreferences() -> JsonRoot? {
    do {
        let fileData = try JSONDecoder().decode(JsonRoot.self, from: JsonReader(jsonFile: AppFiles.nudgePathJson).jsonData)
        return fileData
    } catch {
        OSLog.log(LogMessage.JsonError.jsonReadError + "\(error)", log: OSLog.error, type: .error)
        return nil
    }
}


