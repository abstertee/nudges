//
//  Dates.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/20/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation

class Dates {
    var now = Date()
    var daysRemaining: Int {
        guard let days = getTimeRemaining(nowDate: now,
                                          cutOffdate: cutOffDate,
                                          CalendarComponent: [.day]).day
            else {
                return 999
        }
        return days
    }
    
    var secondsRemaining: Int {
        guard let seconds = getTimeRemaining(nowDate: now,
                                             cutOffdate: cutOffDate,
                                             CalendarComponent: [.second]).second
            else {
                return 99999999
        }
        return seconds
    }
    
    var cutOffDatePretty: String {
        return datePrinter(getDateObject(date: dateFromFile))
    }
    private let dateFormat:String = "yyyy-MM-dd-HH:mm:ss"
    private var dateFromFile:String = nudgePreferences.preferences.cut_off_date
    let dateFormatter = DateFormatter()
    
    var cutOffDate: Date {
        return getDateObject(date: dateFromFile)
    }
    
    private var nowString:String {
        return dateFormatter.string(from: Date())
    }

    private func getTimeRemaining(nowDate:Date, cutOffdate:Date, CalendarComponent: Set<Calendar.Component>) -> DateComponents {
        let component : Set<Calendar.Component> = CalendarComponent
        return Calendar.autoupdatingCurrent.dateComponents(component, from: nowDate, to: cutOffdate)
    }
    
    private func datePrinter(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        // Prints the date in this format: Jul 31,2020
        return dateFormatter.string(from: date)
    }
    
    private func getDateObject(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
        guard let formattedDate = dateFormatter.date(from: date) else {
            print("Failed to get date from file")
            return Date()
        }
        return formattedDate
    }
}
