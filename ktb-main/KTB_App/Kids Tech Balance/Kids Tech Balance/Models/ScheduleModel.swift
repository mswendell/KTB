//
//  ScheduleModel.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 4/23/24.
//

import Foundation
import DeviceActivity

extension DeviceActivityName {
    static let daily = Self("daily")
}

extension DeviceActivityEvent.Name {
    static let encouraged = Self("encouraged")
}

let userdefaults = UserDefaults(suiteName: "group.com.mswendell.Kids-Tech-Balance.tasks")
let endtime = userdefaults!.object(forKey: "enddate") as! Date

let schedule = DeviceActivitySchedule(
    intervalStart: Calendar.current.dateComponents([.hour, .minute], from: Date().addingTimeInterval(-900)),
    intervalEnd: Calendar.current.dateComponents([.hour, .minute], from: endtime),
    repeats: false
)

class ScheduleModel {
    static public func setSchedule() {
        print("Setting up the schedule")
        print("Current time is: ", Calendar.current.dateComponents([.hour, .minute], from: Date()).hour!)

//        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
//            .encouraged: DeviceActivityEvent(
//                applications: DataModel.shared.activitySelection.applicationTokens,
//                threshold: DateComponents(minute: 5)
//            )
//        ]
//        
        let center = DeviceActivityCenter()
        do {
            print("Started Monitoring")
            try center.startMonitoring(.daily, during: schedule)
        } catch {
            print("Error occured while started monitoring: ", error)
        }
    }
    
    static public func endSchedule() {
        let center = DeviceActivityCenter()
        center.stopMonitoring()
    }
}
