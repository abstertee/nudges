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

    @IBOutlet weak var field_deferheading: NSTextField!
    @IBOutlet weak var field_defertext: NSTextField!
    
    @IBOutlet weak var field_titletext: NSTextField!
    @IBOutlet weak var field_subtitletext: NSTextField!
    @IBOutlet weak var field_h2text: NSTextField!
    @IBOutlet weak var field_updated: NSTextField!
    // Buttons

    @IBOutlet weak var snoozeMenu: NSPopUpButton!
    @IBOutlet weak var button_update: NSButton!
    @IBOutlet weak var button_moreinfo: NSButton!
    @IBOutlet weak var button_defer: NSButton!
        
    override func viewWillAppear() {
        super.viewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        globalTimer.resetTimer()
        print(globalTimer.loopTime)
        setTextFields()
        setImage()
        setButtons()
        setSnoozeMenuItems()
    }

    deinit {
        print("Nudge View Controller Deinitialized")
    }

    @IBAction func snoozeMenuChanged(_ sender: NSPopUpButton) {
        //print(sender.selectedTag())
        //OSLog.log("User changed globaltimer to: \(Double(sender.selectedTag())) seconds", log: .info, type: .info)
        logger.write(entry: "User changed globaltimer to: \(Double(sender.selectedTag())) seconds")
        deferPrefs.selectedTime = Double(sender.selectedTag())
        enableSnooze()
    }
    
    @IBAction func image_updates_clicked(_ sender: Any) {
        button_update("ImgeBut")
    }
    
    @IBAction func button_defer(_ sender: NSButton) {
        //print(deferPrefs.selectedTime)
        
        if deferPrefs.selectedTime == 0 {
            return
        }
        
        if deferPrefs.selectedTime != Double(snoozeMenu.selectedTag()) {
            deferPrefs.selectedTime = Double(nudgeViewModel.minDeferTime())//SnoozeMenuItems.OneHour.rawValue)
        }
        //OSLog.log(LogMessage.ButtonActions.buttonDefer, log: OSLog.view, type: .info)
        logger.write(entry: LogMessage.ButtonActions.buttonDefer)
        globalvars.dismissalCount += 1
        //showAgreementSheet()
        let messageText = "Date of Enforcement: \(nudgeViewModel.cutOffDate)"
        let informText = nudgePreferences.userInterface.defer_message //LogMessage.ButtonActions.understoodMessage
        disableSnooze()
        let myAlert = Alerts(currentWindow: nudgewindow.myWindow, messageText: messageText, mainButton: "I Understand", additionalButton: nil, informativeText: informText, windowType: .sheet)
        
        myAlert.alert.beginSheetModal(for: myAlert.currentWindow, completionHandler: { (returnCode) -> Void in
            if returnCode == NSApplication.ModalResponse.alertFirstButtonReturn {
                //OSLog.log("User clicked \(myAlert.mainButton) - \(returnCode)", log: .info, type: .info)
                logger.write(entry: "User clicked \(myAlert.mainButton) - \(returnCode)")
                //myAlert.currentWindow.close()
                windowWillClose()
                self.saveNewPrefs()
            }
        })
                
    }
       
       
    @IBAction func button_moreinfo(_ sender: Any) {
        //OSLog.log(LogMessage.ButtonActions.buttonMoreInfo, log: OSLog.view, type: .info)
        logger.write(entry: LogMessage.ButtonActions.buttonMoreInfo)
        // Open the URL provided in the "more_info_url" json key
        NSWorkspace.shared.open(nudgePreferences.userInterface.more_info_url)
        nudgeViewModel.quitApp()
    }
    
    @IBAction func button_update(_ sender: Any) {
        //OSLog.log(LogMessage.ButtonActions.updateButton, log: OSLog.view, type: .info)
        logger.write(entry: LogMessage.ButtonActions.updateButton)
        let upgradePath = nudgeViewModel.appUpgradePath()
        //OSLog.log(upgradePath.absoluteString, log: OSLog.info, type: .info)
        logger.write(entry: upgradePath.absoluteString)
        if upgradePath.isFileURL {
            nudgeViewModel.launchApp(upgradePath)
        } else {
            nudgeViewModel.launchUrl(upgradePath)
        }
        //nudgewindow.myWindow?.close()
        windowWillClose()
        //OSLog.log(LogMessage.State.windowClosed, log: .info, type: .info)
        logger.write(entry: LogMessage.State.windowClosed)
        //nudgeViewModel.quitApp()
    }
       
    func saveNewPrefs() {
        globalTimer.stopTimer()
        //OSLog.log("User set globaltimer to: \(deferPrefs.selectedTime) seconds", log: .info, type: .info)
        logger.write(entry: "User set globaltimer to: \(deferPrefs.selectedTime) seconds")
        //globalTimer.loopTime = deferPrefs.selectedTime
        globalTimer.startTimer(newLoopTime: deferPrefs.selectedTime)
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "DeferPrefsChanged"),
                                      //object: nil)
        //globalTimer.loopTime = deferPrefs.selectedTime
        
    }
       
}

