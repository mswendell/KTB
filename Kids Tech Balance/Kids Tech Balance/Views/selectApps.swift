//
//  selectApps.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 4/14/24.
//

import SwiftUI
import FamilyControls

struct selectApps: View {
    @State private var pickerIsPresented = false
    @EnvironmentObject var model: DataModel

    var body: some View {
        Button {
            pickerIsPresented = true
        } label: {
            Text("Select Apps")
        }
        .familyActivityPicker(
            isPresented: $pickerIsPresented,
            selection: $model.activitySelection
        )
        .onChange(of: model.activitySelection) { newSelection in
            model.setShieldRestrictions()
        }
        .frame(width: 400, height: 180, alignment: .center)
        .background(.green)
        .foregroundColor(.white)
        .cornerRadius(8)
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    selectApps()
        .environmentObject(DataModel())
}
