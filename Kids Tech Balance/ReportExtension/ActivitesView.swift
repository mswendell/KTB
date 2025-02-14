//
//  ActivitesView.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 5/1/24.
//

import SwiftUI

struct ActivitiesView: View {
    
    var activities: DeviceActivity
    
    var body: some View {
        
        VStack {
            List(activities.apps) { app in
                ListItem(app: app)
            }
        }
        
    }
    
}

//#Preview {
//    ActivitiesView(activities: DeviceActivity(duration: .zero, apps: [AppReport(id: "1", name: "Twitter", duration: .zero)]))
//}
