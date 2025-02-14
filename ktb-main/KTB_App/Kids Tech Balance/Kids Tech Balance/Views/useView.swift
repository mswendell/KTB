//
//  useView.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 3/1/24.
//

import SwiftUI
import LocalAuthentication
import WidgetKit

struct useView: View {
    @Binding var showSet: Bool
    @Binding var showUse: Bool
    @Binding var showReview: Bool
    @EnvironmentObject var model: DataModel
    @State var disableButton = true
    let timeStarted = UserDefaults(suiteName: "group.com.mswendell.Kids-Tech-Balance.tasks")!.object(forKey: "date") as? Date ?? Date()
    let userdefaults = UserDefaults(suiteName: "group.com.mswendell.Kids-Tech-Balance.tasks")
    let formatter = DateFormatter()
    @Binding var tasks: [Todo]
    @Binding var authorize: Bool
    @State var startschedule = UserDefaults.standard.bool(forKey: "schedule")
    
    
    func authenticate (){
        let context = LAContext()
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Please authenticate to proceed.") { (success, error) in
            DispatchQueue.main.async {
                if success {
                    self.disableButton = false
                    authorize = true
                    print("Success")
                }else{
                    authorize = false
                    print("Failed")
                    return
                }
            }
        }
    }
    
    func saveTasks () {
        var names: [String] = []
        var tasktimes: [Int] = []
        var taskdone: [Bool] = []
        tasks.forEach() { item in
            names.append(item.name)
            tasktimes.append(item.time)
            taskdone.append(item.done)
        }
        userdefaults!.set(names, forKey: "taskNames")
        userdefaults!.set(tasktimes, forKey: "taskTimes")
        userdefaults!.set(taskdone, forKey: "taskDone")
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


    
    var body: some View {
        NavigationView {
            
            let totalTime = tasks
                .map( {$0.time})
                .reduce(0, +)
            
            let timeEnd = userdefaults!.object(forKey: "enddate") as? Date ?? timeStarted.addingTimeInterval(TimeInterval(totalTime*60))
            
            
            let time = timeEnd.formatted(date: .omitted, time: .shortened)
            
            if timeEnd < timeStarted {
//                Text("Schedule issue, session cancelled")
//                    .onAppear() {
//                        ScheduleModel.endSchedule()
//                        showUse.toggle()
//                        showReview.toggle()
//                        timer.upstream.connect().cancel()
//                    }
            }
            
            ZStack {
                Button("Back") {
                    if !authorize {
                        authenticate()
                    }
                    if authorize {
                        showUse.toggle()
                        showSet.toggle()
                    }
                }
                .frame(width: 150, height: 40, alignment: .center)
                .background(disableButton ? .gray: .green)
                .foregroundColor(.white)
                .cornerRadius(8)
                .position(CGPoint(x: 100.0, y: 20.0))
                .disabled(disableButton)
                .onAppear() {
                    userdefaults!.set(timeEnd, forKey: "enddate")
                    userdefaults!.set(timeStarted, forKey: "date")
                    if !startschedule {
                        ScheduleModel.setSchedule()
                        startschedule = true
                        UserDefaults.standard.setValue(startschedule, forKey: "schedule")
                    }
                    if authorize {
                        self.disableButton = false
                    }
                }
                
                
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
                            .background(.green)
                            .foregroundColor(.white)
                    }
                    .background(.black)
                    .cornerRadius(10)
                    .frame(width: 450, height: 40, alignment: .center)
                    .padding(.bottom, 20)
                    
                    Text("Ready to Play")
                        .font(.largeTitle)
                        .padding(.bottom, 20)
                    
                    Text("Task List")
                    
                    List {
                        ForEach(tasks.indices, id: \.self) { index in
                            HStack {
                                Text("\(index+1). ")
                                Text(tasks[index].name)
                                Spacer()
                                Text("\(tasks[index].time) Minutes")
                                Button {
                                    tasks[index].done.toggle()
                                    saveTasks()
                                    WidgetCenter.shared.reloadAllTimelines()
                                } label:  {
                                    Image(systemName: tasks[index].done ? "checkmark.circle.fill" : "circle")
                                }
                                .font(.title)
                                .foregroundColor(.green)
                            }
                        }
                    }
                    .frame(minWidth: 200, maxWidth: 400, minHeight: 220, maxHeight: 400)
                    .padding(.bottom, 20)
                    Text("Done playing at \(time)")
                    
                    Button (authorize ? "Next": "Done!") {
                        if authorize {
                            ScheduleModel.endSchedule()
                            showUse.toggle()
                            showReview.toggle()
                        }
                    }
                    .font(.title2)
                    .frame(width: 200, height: 80, alignment: .center)
                    .background(authorize ? .green: .gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .disabled(disableButton)
                    .onReceive (timer){ _ in
                        if timeEnd <= Date.now {
                            self.disableButton.toggle()
                            timer.upstream.connect().cancel()
                        }
                    }
                    
                    Spacer()
                    NavigationLink {
                        authView(authorize: $authorize)
                    } label: {
                        Text(disableButton ? "Parental Override": "Verify Completion")
                    }
                    .frame(width: 150, height: 40, alignment: .center)
                    .background(disableButton ? .red : .green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
//                    Button ("Parental Override") {
//                        authenticate()
//                    }
//                    .frame(width: 150, height: 40, alignment: .center)
//                    .background(.red)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
                    
                }
                .frame(alignment: .center)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    mainMenu(showMenu: false, showTask: false, showSet: false, showUse: true, showReview: false)
        .environmentObject(DataModel())
}
