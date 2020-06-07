//
//  Dates.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation

class Dates: NSObject {
    var daysRemaining: Int {
        return getDaysRemaining(cutOffDateString)
    }
    private let dateFormat:String = "yyyy-MM-dd-HH:mm"
    
    private var cutOffDateString:String = nudgePreferences.cut_off_date
    
    //daysRemaining = self.getDaysRemaining(cutOffDate: nudgePreferences.preferences.cut_off_date)
    
    private func getDaysRemaining(_ DateString:String) -> Int {
        let calendar = Calendar.autoupdatingCurrent
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let cutOff = dateFormatter.date(from: DateString)
        let cutOffDay = calendar.startOfDay(for: cutOff!)
        let today = calendar.startOfDay(for: Date())
        guard let daysRemaining = calendar.dateComponents([.day], from: today, to: cutOffDay).day else {
            return 1
        }
        return daysRemaining
    }

}
