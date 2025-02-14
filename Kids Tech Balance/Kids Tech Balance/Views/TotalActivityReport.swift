//
//  activityViews.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 5/1/24.
//

import SwiftUI
import DeviceActivity

extension DeviceActivityReport.Context {
    static let totalActivity = Self("Activities")
}

struct TotalActivityReport: DeviceActivityReportScene {
    
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .totalActivity
    
    // Define the custom configuration and the resulting view for this report.
    let content: (DeviceActivity) -> TotalActivityView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> DeviceActivity {
        
        var list: [AppReport] = []
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        
        for await _data in data {
            for await activity in _data.activitySegments {
                for await category in activity.categories {
                    for await app in category.applications {
                        let appName = (app.application.localizedDisplayName ?? "nil")
                        let bundle = (app.application.bundleIdentifier ?? "nil")
                        let duration = app.totalActivityDuration
                        let app = AppReport(id: bundle, name: appName, duration: duration)
                        list.append(app)
                    }
                }
            }
        }
        
        return DeviceActivity(duration: totalActivityDuration, apps: list)
    }
}
