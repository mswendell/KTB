//
//  reviewView.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 3/1/24.
//

import SwiftUI
import DeviceActivity
import WidgetKit

struct reviewView: View {
    @Binding var showUse: Bool
    @Binding var showReview: Bool
    @Binding var showMenu: Bool
    @Binding var tasks: [Todo]
    @EnvironmentObject var model: DataModel
    let userdefaults = UserDefaults(suiteName: "group.com.mswendell.Kids-Tech-Balance.tasks")
    let timeStarted = UserDefaults(suiteName: "group.com.mswendell.Kids-Tech-Balance.tasks")!.object(forKey: "date") as? Date ?? Date()
    let timeEnd = UserDefaults(suiteName: "group.com.mswendell.Kids-Tech-Balance.tasks")!.object(forKey: "enddate") as? Date ?? Date()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Review")
                .font(.title)
            HStack {
                VStack {
                    Text("Use History")
                    HStack {
                        VStack {
                            Text("App")
                            if timeEnd < timeStarted {
                                Text("Error with Date Entry. Make sure to press Finish button after each session.")
                                    .foregroundColor(.red)
                            }
                            else  {
                                DeviceActivityReportAdapter()
                                    .frame(width: 400)
                            }
                        }
                        .frame(minWidth: 10, idealWidth: 100, maxWidth: 600)
                        VStack {
                            Text("Tasks")
                            Spacer()
                            List {
                                ForEach(tasks.indices, id: \.self) { index in
                                    HStack {
                                        Text("\(index+1). ")
                                        Text(tasks[index].name)
                                        Spacer()
                                        Text("\(tasks[index].time) Minutes")
                                        Image(systemName: tasks[index].done ? "checkmark.circle.fill" : "circle")
                                            .font(.title)
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .frame(width: 400)
                            Spacer()
                        }
                        .frame(minWidth: 10, idealWidth: 100, maxWidth: 600)
                    }
                    
                }

            }
            Button("Finish") {
                showReview.toggle()
                showMenu.toggle()
                model.removesheildRestrictions()
                userdefaults!.setValue(nil, forKey: "date")
                userdefaults!.setValue(nil, forKey: "enddate")
                userdefaults!.setValue(nil, forKey: "tasks")
                userdefaults!.setValue(nil, forKey: "taskNames")
                userdefaults!.setValue(nil, forKey: "taskTimes")
                UserDefaults.standard.setValue(false, forKey: "schedule")
                tasks.removeAll()
                WidgetCenter.shared.reloadAllTimelines()
            }
            .frame(width: 150, height: 40, alignment: .center)
            .background(.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            Spacer()
        }
    }
}

#Preview {
    mainMenu(showMenu: false, showTask: false, showSet: false, showUse: false, showReview: true)
        .environmentObject(DataModel())
}
