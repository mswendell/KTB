//
//  mainMenu.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 3/1/24.
//

import SwiftUI
import FamilyControls
import WidgetKit

struct CustomButtonStyle: ButtonStyle {
    @State var pressed = false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 150, height: 25)
            .background(pressed ? Color.green.opacity(0.8) : Color.gray.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .onTapGesture {
                pressed.toggle()
            }
    }
}


struct mainMenu: View {
    @State var showMenu = true
    @State var showTask = false
    @State var showSet = false
    @State var showUse = false
    @State var showReview = false
    @State var showPassword = false
    @State var authorize = false
    @EnvironmentObject var model: DataModel
    @State var tasks: [Todo] = []
    let userdefaults = UserDefaults(suiteName: "group.com.mswendell.Kids-Tech-Balance.tasks")
    
    func checkDate() {
        if userdefaults!.object(forKey: "date") != nil {
            showUse.toggle()
            showMenu.toggle()
        }
    }
    
    func readTasks() {
        let names: [String] = userdefaults!.array(forKey: "taskNames") as? [String] ?? []
        let tasktimes: [Int] = userdefaults!.array(forKey: "taskTimes") as? [Int] ?? []
        let taskDone: [Bool] = userdefaults!.array(forKey: "taskDone") as? [Bool] ?? []
        for (index, _) in names.enumerated() {
            tasks.append(Todo(name: names[index], time: tasktimes[index], done: taskDone[index]))
        }
    }
    
    var body: some View {
        
        if showMenu {
            VStack {
                Text("Kid Tech Balance")
                    .font(.largeTitle)
                    .padding()
                Spacer()
                    VStack {
                        Spacer()
                        Button("Start") {
                            showMenu.toggle()
                            showTask.toggle()
                        }
                        .frame(width: 400, height: 180, alignment: .center)
                        .background(.green)
                        .cornerRadius(8)
                        .font(.largeTitle)
                        .bold()
                        
                        Spacer()
                        HStack {
                            Spacer()
                            Button("Settings") {
                                showMenu.toggle()
                                showPassword.toggle()
                            }
                            .frame(width: 200, height: 40, alignment: .center)
                            .background(.green)
                            .cornerRadius(8)
                            .padding(.leading, 150)
                            
                            Spacer()
                            Button("Reset") {
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
                            .frame(width: 100, height: 40, alignment: .center)
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.trailing, 50)
                        }
                    }
                    .foregroundColor(.white)
                    Spacer()
                    
                    
                }
                .multilineTextAlignment(.center)
                .onAppear() {
                    checkDate()
                    if tasks.isEmpty {
                        readTasks()
                    }
                }
            }
        if showTask {
            taskView(showMenu: $showMenu, showTask: $showTask, showSet: $showSet, tasks: $tasks)
        }
        if showSet {
            setView(showTask: $showTask, showSet: $showSet, showUse: $showUse, authorize: $authorize)
                .environmentObject(model)
        }
        if showUse {
            useView(showSet: $showSet, showUse: $showUse, showReview: $showReview, tasks: $tasks, authorize: $authorize)
                .environmentObject(model)
            
        }
        if showReview {
            reviewView(showUse: $showUse, showReview: $showReview, showMenu: $showMenu, tasks: $tasks)
        }
        if showPassword {
            parentSettings(showMenu: $showMenu, showPassword: $showPassword)
        }
    }
}

#Preview {
    
    mainMenu(showMenu: true, showTask: false, showSet: false, showUse: false, showReview: false)
        .environmentObject(DataModel())
}
