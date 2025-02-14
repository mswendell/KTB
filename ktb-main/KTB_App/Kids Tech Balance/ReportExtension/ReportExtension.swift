//
//  ReportExtension.swift
//  ReportExtension
//
//  Created by Michael Wendell on 5/1/24.
//

import DeviceActivity
import SwiftUI

@main
struct ReportExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(deviceActivity: totalActivity)
        }
        // Add more reports here...
    }
}
