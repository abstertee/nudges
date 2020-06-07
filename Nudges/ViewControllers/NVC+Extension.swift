//
//  NVC+Extension.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation
import Cocoa
import os

extension NudgeViewController {

func setButtons() {
    
   // Show or Hide the More Info button
       button_moreinfo.isHidden = false
    
    // Show Hide Defer Button
    if nudgeViewModel.dismissalCounter() || Dates().daysRemaining <= 0 {
        // Dismmissal has reached threshold OR no more days remaining
        button_defer.isHidden = true
    } else {
        // Dimissal has NOT reached threshold
        button_defer.isHidden = false
        button_defer.isHighlighted = true
    }
   }
   
   func setImage() {
        image_companylogo.image = nudgeViewModel.companyLogo
        image_updates.image = nudgeViewModel.getScreenShot()
       
   }
   
   func setTextFields() {
        field_username.stringValue = systemInfo.currentUser
        field_serialnumber.stringValue = systemInfo.serialNumber
        field_h1text.stringValue = nudgePreferences.button_title_text
        field_h2text.stringValue = nudgePreferences.button_sub_titletext
        field_paragraph1.stringValue = nudgePreferences.paragraph1_text
        field_paragraph2.stringValue = nudgePreferences.paragraph2_text
        field_paragraph3.stringValue = nudgePreferences.paragraph3_text
        field_subtitletext.stringValue = nudgePreferences.main_subtitle_text
        field_titletext.stringValue = nudgePreferences.main_title_text
        field_updatetext.stringValue = nudgePreferences.paragraph_title_text
        if nudgeViewModel.daysRemainingCalc() > 0 {
                field_daysremaining.integerValue = nudgeViewModel.daysRemainingCalc()
        } else {
            field_daysremaining.stringValue = "Past Due!"
        }
        
        field_updated.stringValue = nudgeViewModel.fullyUpdated().description

   }
    
    func showAgreementSheet() {
        let alert = NSAlert()
        alert.messageText = "\(nudgeViewModel.daysRemainingCalc()) Days Remaining Until Enforcement" 
        alert.informativeText = "The IT team will begin upgrade enforcement in \(nudgeViewModel.daysRemainingCalc()) days. At that time, your system will be updated without any notifications."
        alert.addButton(withTitle: "I Understand")
        alert.alertStyle = .warning
        alert.icon = nudgeViewModel.getScreenShot()
        alert.beginSheetModal(for: self.window, completionHandler: { (returnCode) -> Void in
            OSLog.log(LogMessage.ButtonActions.buttonUnderstood, log: OSLog.info, type: .info)
            self.window.close()
            
        })
    }
   
}
