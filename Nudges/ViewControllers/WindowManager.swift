//
//  nudgeWindow.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/26/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Cocoa

class WindowManager: NSWindowController {
    
    var myWindow: NSWindow? = nil
    
    func launchWindow() {
        let mainStoryboard = NSStoryboard(name: "Main", bundle: nil)
        let sourceViewController: NSViewController = mainStoryboard.instantiateController(withIdentifier: "mainWindowController") as! NudgeViewController
        myWindow = Window(contentViewController: sourceViewController)
        myWindow?.makeKeyAndOrderFront(self)

        let vc = NudgeWindowController(window: myWindow)
        vc.showWindow(self)
        //GlobalTimer.sharedTimer.stopTimer()
    }
    
    func closeWindow() {
        GlobalTimer.sharedTimer.startTimer(andJob: determineStateAndNudge)
    }


}
var nudgewindow = WindowManager()
