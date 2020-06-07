//
//  GlobalVars.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//
import AppKit
import Foundation

struct GlobalVars {
    var workspace = NSWorkspace.shared
    var dismissalThreshold = nudgePreferences.dismissal_count_threshold
    var dismissalCount: Int = 0
    var acceptableApps: [String] = [
        "com.apple.loginwindow",
        "com.apple.systempreferences",
        "com.tarent.Nudges"
    ]
    var pathToUpdate = nudgePreferences.path_to_app
    var moreInfoUrl:URL = nudgePreferences.more_info_url
    
}

var globalvars = GlobalVars()
