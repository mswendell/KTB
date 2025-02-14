//
//  ListItem.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 5/1/24.
//

import SwiftUI

struct ListItem: View {
    
    private let app: AppReport
    
    init(app: AppReport) {
        self.app = app
    }
    
    var body: some View {
        HStack {
            Label(app.token).labelStyle(.iconOnly)
            VStack {
                Text(app.name)
            }
            
            Spacer()
            Spacer()
            Text(app.duration.toString())
        }
    }
}
