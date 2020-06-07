//
//  Log.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//
import os.log
import Foundation
import Cocoa

extension OSLog {
    private static var subsystem:String = Bundle.main.bundleIdentifier ?? "com.tarent.Nudges"
    static let info = OSLog(subsystem: subsystem, category: "information")
    static let view = OSLog(subsystem: subsystem, category: "view")
    static let error = OSLog(subsystem: subsystem, category: "ERROR")
    //static let success = OSLog(subsystem: subsystem, category: "SUCCESS")
    
    static func log(_ message: String, log: OSLog = .default, type: OSLogType = .default) {
           os_log("%@", log: log, type: type, message)
       }
}
