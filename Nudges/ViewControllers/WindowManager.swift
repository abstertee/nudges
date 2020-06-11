//
//  nudgeWindow.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/26/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Cocoa

class WindowManager: NSObject, NSWindowDelegate {
    var myWindow: NSWindow? = nil
    weak var viewControl: NSWindowController? = nil
    
    func launchWindow() {
        let mainStoryboard = NSStoryboard(name: "Main", bundle: nil)
        let sourceViewController: NSViewController = mainStoryboard.instantiateController(withIdentifier: "mainWindowController") as! NudgeViewController
        myWindow = Window(contentViewController: sourceViewController)
        myWindow?.makeKeyAndOrderFront(self)

        //let vc = NudgeWindowController(window: myWindow)
        //vc.showWindow(self)
        viewControl = NudgeWindowController(window: myWindow)
        viewControl?.showWindow(self)
        //print("View Loaded fom storyboard")
    }
    
    func closeWindow() {
        //print("Window Closed")
        viewControl = nil
    }
    
    deinit {
        //print("WindowManager deinitialized")
        viewControl = nil
    }
}

var nudgewindow = WindowManager()

