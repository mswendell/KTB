//
//  setView.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 3/1/24.
//

import SwiftUI
import FamilyControls
import Combine
import DeviceActivity
import WidgetKit

struct setView: View {
    @Binding var showTask: Bool
    @Binding var showSet: Bool
    @Binding var showUse: Bool
    @Binding var authorize: Bool
    @State private var pickerIsPresented = false
    @EnvironmentObject var model: DataModel
    let userdefaults = UserDefaults(suiteName: "group.com.mswendell.Kids-Tech-Balance.tasks")
    
    var body: some View {
        ZStack {
            Button("Back") {
                showSet.toggle()
                showTask.toggle()
            }
            .frame(width: 150, height: 40, alignment: .center)
            .background(.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            .position(CGPoint(x: 100.0, y: 20.0))
            VStack {
                
                HStack(spacing: 1) {
                    Text ("Ready")
                        .frame(width: 150, height: 40, alignment: .center)
                    .background(.green)
                    .foregroundColor(.white)
                    Text ("Set")
                        .frame(width: 150, height: 40, alignment: .center)
                        .background(.green)
                        .foregroundColor(.white)
                    Text ("Play")
                        .frame(width: 150, height: 40, alignment: .center)
                        .background(.gray)
                        .foregroundColor(.white)
                }
                .background(.black)
                .cornerRadius(10)
                .frame(width: 450, height: 40, alignment: .center)
                .padding(.bottom, 20)
                
                Text("Restrictions")
                    .font(.largeTitle)
                    .padding(.bottom, 90)
                
                VStack {

                    selectApps()
                        .environmentObject(model)
                        .bold()
                }
                .padding(.top, 150)
                Spacer()
                
                
                Button("Next") {
                    userdefaults!.set(Date(), forKey: "date")
                    showSet.toggle()
                    showUse.toggle()
                    WidgetCenter.shared.reloadAllTimelines()
                    authorize = false
                }
                .frame(width: 150, height: 40, alignment: .center)
                .background(.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }

    }
    
}

#Preview {
    mainMenu(showMenu: false, showTask: false, showSet: true, showUse: false, showReview: false)
        .environmentObject(DataModel())
}
