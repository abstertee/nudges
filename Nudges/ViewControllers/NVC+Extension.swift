//
//  NVC+Extension.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation
import Cocoa
//import os


extension NudgeViewController {

    func setButtons() {
        button_update.isHighlighted = true
        // Show or Hide the More Info button
        if nudgePreferences.userInterface.more_info_url.absoluteString.isEmpty {
            button_moreinfo.isHidden = true
        }
        button_moreinfo.isHidden = false
        disableSnooze()
        // Show Hide Defer Button
        if nudgeViewModel.dismissalCounter() || nudgeViewModel.enforce {
            // Dismmissal has reached threshold OR no more days remaining
            //disableSnooze()
            snoozeMenu.isHidden = true
        } else {
            // Dimissal has NOT reached threshold
            //enableSnooze()
            snoozeMenu.isHidden = false
            //button_defer.isHighlighted = true
        }
    }

    func setImage() {
        image_companylogo.image = nudgeViewModel.companyLogo
        image_updates.image = nudgeViewModel.getScreenShot()
    }
    
    func enableSnooze() {
        button_defer.isHidden = false
        button_defer.isEnabled = true
    }
    
    func disableSnooze() {
        button_defer.isEnabled = false
    }
    
    func setTextFields() {
        field_username.stringValue = systemInfo.currentUser
        field_serialnumber.stringValue = systemInfo.serialNumber
        field_h1text.stringValue = nudgePreferences.userInterface.button_title_text
        field_h2text.stringValue = nudgePreferences.userInterface.button_sub_titletext
        field_deferheading.stringValue = nudgePreferences.userInterface.defer_heading
        field_defertext.stringValue = nudgePreferences.userInterface.defer_text
        field_paragraph1.stringValue = nudgePreferences.userInterface.paragraph1_text
        field_paragraph2.stringValue = nudgePreferences.userInterface.paragraph2_text
        field_paragraph3.stringValue = nudgePreferences.userInterface.paragraph3_text
        field_subtitletext.stringValue = nudgePreferences.userInterface.main_subtitle_text
        field_titletext.stringValue = nudgePreferences.userInterface.main_title_text
        field_updatetext.stringValue = nudgePreferences.userInterface.paragraph_title_text
        if nudgeViewModel.enforce {
            field_daysremaining.stringValue = "Past Due!"
            field_daysremaining.textColor = .red
            field_defertext.isHidden = true
            field_deferheading.isHidden = true
                
        } else {
            field_daysremaining.integerValue = nudgeViewModel.daysRemainingCalc()
        }
        field_updated.stringValue = nudgeViewModel.fullyUpdated().description
    }
    
    func setSnoozeMenuItems() {
        snoozeMenu.removeAllItems()
        let myMenu = NSMenu()
        let defaultMenuItem = NSMenuItem()
        defaultMenuItem.title = "-- Select --"
        defaultMenuItem.tag = 0
        myMenu.addItem(defaultMenuItem)
        for snoozeMenuItem in nudgePreferences.preferences.defer_options {
            if snoozeMenuItem.seconds < nudgeViewModel.dates.secondsRemaining {
                let menuItem = NSMenuItem()
                menuItem.title = snoozeMenuItem.text
                menuItem.tag = snoozeMenuItem.seconds
                myMenu.addItem(menuItem)
            }
        }
        /*for snoozeMenuItem in SnoozeMenuItems.allCases {
            if snoozeMenuItem.rawValue < nudgeViewModel.dates.secondsRemaining {
                let menuItem = NSMenuItem()
                menuItem.title = snoozeMenuItem.snoozeTimeString
                menuItem.tag = snoozeMenuItem.rawValue
                myMenu.addItem(menuItem)
            }
        }*/
        snoozeMenu.menu = myMenu
        // Find the max time available to set the options in the menu
        let max = snoozeMenu.menu?.items.max { a, b in a.tag < b.tag }
        print("Max item in array \(max!.tag)")
        //snoozeMenu.selectItem(withTag: max!.tag)
        snoozeMenu.selectItem(withTag: 0)
        deferPrefs.selectedTime = Double(snoozeMenu.selectedTag())
        // Set the timer to default to 1 hour
        // if the user did not select one from the menu
        /*if deferPrefs.selectedTime != Double(snoozeMenu.selectedTag()) {
            deferPrefs.selectedTime = Double(nudgeViewModel.minDeferTime())
        }*/
    }
}
