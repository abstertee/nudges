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

class Log {
    
    private let logFileUrl = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first?.appendingPathComponent("Logs").appendingPathComponent("nudge.log")
    
    private func getDate() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeStamp = formatter.string(from: now)
        return timeStamp
    }
    
    func write(entry: String) {
        if FileManager.default.fileExists(atPath: logFileUrl!.path) == false {
            FileManager.default.createFile(atPath: logFileUrl!.path,
                                           contents: .none,
                                           attributes: [
                                            .groupOwnerAccountID: 20,
                                            .posixPermissions: 0o777
                                           ])
        }
        
        let message = (getDate() + ": " + entry + "\n").data(using: String.Encoding.utf8)!
        if let fileHandle = try? FileHandle(forWritingTo: logFileUrl!) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(message)
            fileHandle.closeFile()
        }
    }
}

let logger = Log()
