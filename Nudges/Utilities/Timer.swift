//
//  Timer.swift
//  Nudges
//
//  Created by Abraham Tarverdi on 5/21/20.
//  Copyright © 2020 Tarverdi Enterprises. All rights reserved.
//

import Foundation

class GlobalTimer: NSObject {
    static let sharedTimer: GlobalTimer = {
        let timer = GlobalTimer()
        return timer
    }()
    
    private var internalTimer: Timer?
    private var jobs = [() -> Void]()
    
    func stopTimer(){
        guard self.internalTimer != nil else {
            debugPrint(LogMessage.Timer.noTimerActive)
            return
        }
        self.internalTimer?.invalidate()
    }
    
    func startTimer(andJob job: @escaping () -> Void) {
        if self.internalTimer != nil {
            debugPrint(LogMessage.Timer.running)
            internalTimer?.invalidate()
        }
        jobs.append(job)
        activateWindow()
        self.internalTimer = Timer.scheduledTimer(timeInterval: getTimeValue() /*seconds*/, target: self, selector: #selector(activateWindow), userInfo: nil, repeats: true)
        internalTimer?.fire()
    }
    
    private func getTimeValue() -> Double {
        //let timerFromJson = nudgePreferences.timer_timer
        let timerFromJson = 10  //<- Set to X seconds for testing
        debugPrint("Timer set to \(timerFromJson) seconds from plist.")
        return Double(timerFromJson)
    }
    
    @objc func activateWindow(){
        debugPrint("Timer Set. Countdown from \(getTimeValue()) seconds.")
        determineStateAndNudge()
    }
}

