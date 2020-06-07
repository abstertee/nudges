//
//  Preferences.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation

struct AppFiles {
    // Folders
    static let nudgePath = FileManager.default.urls(for: .libraryDirectory, in: .localDomainMask)[0].appendingPathComponent("nudges")
    static let nudgePath_resources = nudgePath.appendingPathComponent("Resources")
    static let nudgePath_logs = nudgePath.appendingPathComponent("Logs")
    
    // Files
    static let nudgePathJson = AppFiles.nudgePath_resources.appendingPathComponent("nudge.json")
    static let nudgePathLog = AppFiles.nudgePath_logs.appendingPathComponent("nudge.log")
}



func setPreferences() -> JsonRoot? {
    guard let fileData = try? JSONDecoder().decode(JsonRoot.self, from: JsonReader(jsonFile: AppFiles.nudgePathJson).jsonData) else {
        return nil
    }
    return fileData
    
}

var nudgePreferencesRaw: JsonRoot? = setPreferences()
let nudgePreferences = nudgePreferencesRaw!.preferences


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
    let timer_timer: Int
    let update_minor: Bool
    let update_minor_days: Int
}

