//
//  Alerts.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/28/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation
import Cocoa
import os.log

class Alerts {
    var icon: NSImage? {
        if let myIcon = NSImage(named: "warningicon") {
            return myIcon
        }
        return nil
    }
    
    var alert = NSAlert()
    
    var currentWindow: NSWindow
    var messageText: String
    var mainButton: String
    var additionalButton: String?
    var informativeText:String
    var windowType:AlertWindowType
    
    init(currentWindow:NSWindow?, messageText:String, mainButton:String, additionalButton:String?, informativeText:String, windowType:AlertWindowType) {
        
        self.currentWindow = currentWindow!
        self.messageText = messageText
        self.mainButton = mainButton
        self.additionalButton = additionalButton
        self.informativeText = informativeText
        self.windowType = windowType
        
        alert.messageText = messageText
        alert.informativeText = informativeText
        alert.addButton(withTitle: mainButton)
        if let anotherButton = additionalButton {
            alert.addButton(withTitle: anotherButton)
        }
    }
}

enum AlertWindowType: String {
    case sheet, window
}
