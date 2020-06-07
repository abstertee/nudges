//
//  SystemInfo.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation

var systemInfo:SystemInfo = SystemInfo()
struct SystemInfo {
    
    var serialNumber: String = getMacSerialNumber()
    var currentUser: String = getCurrentUser()
    var osVersion: String
    var majorOs: Int = ProcessInfo.processInfo.operatingSystemVersion.majorVersion
    var minorOs: Int = ProcessInfo.processInfo.operatingSystemVersion.minorVersion
    var patchOs: Int = ProcessInfo.processInfo.operatingSystemVersion.patchVersion
    
    init() {
        self.osVersion = "\(self.majorOs).\(self.minorOs).\(self.patchOs)"
    }
    
}

func getMacSerialNumber() -> String {
        var serialNumber: String? {
        let platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice") )
        
        guard platformExpert > 0 else {
            return nil
        }
        
        guard let serialNumber = (IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0).takeUnretainedValue() as? String)?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) else {
            return nil
        }
        
        IOObjectRelease(platformExpert)

        return serialNumber
    }
    
    return serialNumber ?? "Unknown"
}

func getCurrentUser() -> String {
    return NSUserName()
}


