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

class Alerts: NSObject {
    static let shared: Alerts = {
        let alert = Alerts()
        return alert
    }()
    
    //let alert = NSAlert()
    
    enum AlertWindowType: String {
        case sheet, window
    }
    
    // Display Message if an error occurs
    func alertMessage(_ currentWindow:NSWindow?,_ messageText:String,_  mainButton:String,_ additionalButton:String?,_ informativeText:String,_ windowType:AlertWindowType) {
        switch windowType {
        case .sheet:
            alertSheet(currentWindow!, messageText, mainButton, additionalButton, informativeText)
        case .window:
            alertWindow(messageText, mainButton, additionalButton!, informativeText)
        }
    }
    
    private func alertSheet(_ currentWindow:NSWindow, _ messageText:String, _ mainButton:String, _ additionalButton:String?, _ informativeText:String) {
        let alert = NSAlert()
        alert.messageText = messageText // Edit as Required
        alert.informativeText = informativeText // Edit as Required
        alert.addButton(withTitle: mainButton)
        if additionalButton != nil {
            alert.addButton(withTitle: additionalButton!)
        }
        
        OSLog.log(messageText, log: .info, type: .info)
        alert.beginSheetModal(for: currentWindow, completionHandler: { (returnCode) -> Void in
            if returnCode == NSApplication.ModalResponse.alertFirstButtonReturn {
                //logger.write("Alert: \(mainButton) Button pressed: \(returnCode)")
                OSLog.log("User clicked \(mainButton) - \(returnCode)", log: .info, type: .info)
                currentWindow.close()
            } else if returnCode == NSApplication.ModalResponse.alertSecondButtonReturn {
                //logger.write("Alert: \(additionalButton) Button pressed")
                OSLog.log("User clicked \(additionalButton) - \(returnCode)", log: .info, type: .info)
                exit(1)
            }
        })
    }
    
    private func alertWindow(_ messageText:String, _ mainButton:String, _ additionalButton:String?, _ informativeText:String) {
        let alert = NSAlert()
        alert.messageText = messageText // Edit as Required
        alert.informativeText = informativeText // Edit as Required
        alert.addButton(withTitle: mainButton)
        if additionalButton != nil {
            alert.addButton(withTitle: additionalButton!)
        }
        _ = alert.runModal()
        exit(1)
    }
}
