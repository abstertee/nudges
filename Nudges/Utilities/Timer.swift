//
//  Timer.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/21/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation
import os.log

struct GlobalTimerDefaultValues {
    let loopTime:Double = 5.0
}

class GlobalTimer {
    var timer: Timer? = nil
    var startTime: Date?
    var loopTime: Double = GlobalTimerDefaultValues().loopTime
    
    func resetTimer() {
        stopTimer()
        startTimer(newLoopTime: GlobalTimerDefaultValues().loopTime)
    }
    
    func stopTimer() {
        print("Stopping Timer")
        timer?.invalidate()
        timer = nil
        //timerAction()
    }
    
    func startTimer(newLoopTime: Double?) {
        print("Starting Timer")
        timer = Timer.scheduledTimer(timeInterval: newLoopTime ?? GlobalTimerDefaultValues().loopTime,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func timerAction() {
        determineStateAndNudge()
    }
    
    private func getTimeValue() -> Double {

        if nudgePreferences.timer.no_timer {
            return loopTime
        }
        
        let timerFromJson = Double(nudgePreferences.timer.timer_initial)
        loopTime = timerFromJson
        //let timerFromJson = 5  //<- Set to X seconds for testing
        //OSLog.log("Timer set to \(timerFromJson)", log: .info, type: .info)
        logger.write(entry: "Timer set to \(timerFromJson)")
        return loopTime
    }
}

var globalTimer = GlobalTimer()
