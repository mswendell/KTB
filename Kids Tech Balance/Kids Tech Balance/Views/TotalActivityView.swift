//
//  TotalActivitesView.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 5/1/24.
//

import SwiftUI

struct TotalActivityView: View {
    var deviceActivity: DeviceActivity
    
    var body: some View {
        ActivitiesView(activities: deviceActivity)
    }
    
}
