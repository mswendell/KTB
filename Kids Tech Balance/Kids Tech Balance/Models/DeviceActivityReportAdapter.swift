//
//  DeviceActivityReportAdapter.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 5/1/24.
//

import SwiftUI
import DeviceActivity

struct DeviceActivityReportAdapter: View {
    
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: DateInterval(start: UserDefaults(suiteName: "group.com.mswendell.Kids-Tech-Balance.tasks")!.object(forKey: "date") as? Date ?? Date(), end: UserDefaults(suiteName: "group.com.mswendell.Kids-Tech-Balance.tasks")!.object(forKey: "enddate") as? Date ?? Date())
        ),
        users: .all,
        devices: .init([.iPad])
    )
    
    var body: some View {
        ZStack {
            DeviceActivityReport(context, filter: filter)
        }
    }
}

#Preview {
    DeviceActivityReportAdapter()
}
