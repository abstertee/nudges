//
//  DeferMenu.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 2/10/21.
//  Copyright © 2021 Tarverdi Enterprises. All rights reserved.
//

import Foundation

struct DeferPrefs {
    var selectedTime: TimeInterval {
        get {
          let savedTime = UserDefaults.standard.double(forKey: "selectedTime")
          if savedTime > 0 {
            return savedTime
          }
          return 0
        }
        set {
          UserDefaults.standard.set(newValue, forKey: "selectedTime")
        }
    }
}
var deferPrefs = DeferPrefs()
