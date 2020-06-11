//
//  NudgeWindowController.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/21/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Cocoa

class NudgeWindowController: NSWindowController {
    override func loadWindow() {
        let screenSize: NSRect = (NSScreen.main?.frame)!
        let percent: CGFloat = 1.0
        let offset: CGFloat = (1.0-percent)/2.0
        let windowRect = NSMakeRect(screenSize.size.width*offset, screenSize.size.height*offset, 850, 475)
        let window = Window(contentRect: windowRect, styleMask: [.borderless], backing: .buffered, defer: true)
        window.center()
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        //contentViewController = NudgeViewController()
        window?.isMovableByWindowBackground = true
        window?.isMovable = false
    }
}

class Window: NSWindow {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: [.fullSizeContentView], backing: .buffered, defer: true)
        isMovableByWindowBackground = true
        isMovable = false
    }
}
