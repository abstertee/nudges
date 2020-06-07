//
//  ViewController.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Cocoa
import os

class NudgeViewController: NSViewController {
    
    // Fields
    @IBOutlet weak var field_paragraph1: NSTextField!
    @IBOutlet weak var field_paragraph2: NSTextField!
    @IBOutlet weak var field_paragraph3: NSTextField!
    @IBOutlet weak var image_companylogo: NSImageView!
    @IBOutlet weak var field_username: NSTextField!
    @IBOutlet weak var field_serialnumber: NSTextField!
    @IBOutlet weak var field_daysremaining: NSTextField!
    @IBOutlet weak var field_updatetext: NSTextField!
    @IBOutlet weak var field_h1text: NSTextField!
    @IBOutlet weak var image_updates: NSImageView!
    @IBOutlet weak var field_daysremainingtext: NSTextField!

    @IBOutlet weak var field_titletext: NSTextField!
    @IBOutlet weak var field_subtitletext: NSTextField!
    @IBOutlet weak var field_h2text: NSTextField!
    @IBOutlet weak var field_updated: NSTextField!
    // Buttons

    @IBOutlet weak var button_understand: NSButton!
    @IBOutlet weak var button_moreinfo: NSButton!
    @IBOutlet weak var button_defer: NSButton!
    
    lazy var window: NSWindow! = self.view.window
    override func viewWillAppear() {
        super.viewWillAppear()
        window.titleVisibility = .hidden
    }
    var nudgeViewModel = NudgeViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTextFields()
        setImage()
        setButtons()
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func image_updates_clicked(_ sender: Any) {
        
    }
    
    @IBAction func button_defer(_ sender: NSButton) {
        //print(globalvars.dismissalCount)
        OSLog.log(LogMessage.ButtonActions.buttonDefer, log: OSLog.view, type: .info)
        globalvars.dismissalCount += 1
        //showAgreementSheet()
        let messageText = "Days Remaining Until Enforcement: \(nudgeViewModel.daysRemainingCalc())"
        let informText = LogMessage.ButtonActions.understoodMessage
    Alerts.shared.alertMessage(currentWindow: nudgewindow.myWindow, messageText: messageText, mainButton: "I Understand", additionalButton: "", informativeText: informText, windowType: .sheet)
        button_defer.isHidden = true
    }
       
       
    @IBAction func button_moreinfo(_ sender: Any) {
        OSLog.log(LogMessage.ButtonActions.buttonMoreInfo, log: OSLog.view, type: .info)
        // Open the URL provided in the "more_info_url" json key
        NSWorkspace.shared.open(nudgePreferences.more_info_url)
    }
    
    @IBAction func button_update(_ sender: Any) {
        OSLog.log(LogMessage.ButtonActions.updateButton, log: OSLog.view, type: .info)
        if FileManager.default.fileExists(atPath: nudgePreferences.path_to_app) == false {
            OSLog.log(LogMessage.ApplicationFiles.pathToAppMissing, log: OSLog.error, type: .error)
            //logger.write(LogMessage.ApplicationFiles.pathToAppMissing)
            Alerts.shared.alertMessage(currentWindow: self.window, messageText: "Uh Oh!", mainButton: "Ok", additionalButton: "", informativeText: LogMessage.ApplicationFiles.pathToAppMissing, windowType: .sheet)
            return
        }
        //print(nudgePreferences.path_to_app)
        let pathToAppUrl = URL(fileURLWithPath: nudgePreferences.path_to_app)
        //print(pathToAppUrl)
        let nsworkspaceOpenConfig = NSWorkspace.OpenConfiguration()
        nsworkspaceOpenConfig.activates = true
        NSWorkspace.shared.openApplication(at: pathToAppUrl as URL, configuration: nsworkspaceOpenConfig, completionHandler: nil)
        //NSWorkspace.shared.open(URL(string: nudgePreferences.path_to_app)!)
    }
       
       
}

