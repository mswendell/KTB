//
//  taskView.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 3/1/24.
//

import SwiftUI


struct Todo {
    var name: String
    var time: Int
    var done: Bool
}

struct taskView: View {
    @Binding var showMenu: Bool
    @Binding var showTask: Bool
    @Binding var showSet: Bool
    @Binding var tasks: [Todo]
    @State private var newTaskName = ""
    @State private var newTaskTime = 30
    @State var disableButton = true

    
    var body: some View {
        ZStack {
            Button("Back") {
                showTask.toggle()
                showMenu.toggle()
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
                        .background(.gray)
                        .foregroundColor(.white)
                    Text ("Play")
                        .frame(width: 150, height: 40, alignment: .center)
                        .background(.gray)
                        .foregroundColor(.white)
                }
                .background(.black)
                .cornerRadius(10)
                .frame(width: 450, height: 40, alignment: .center)
                .padding(.bottom, 30)
                
                
                VStack {
                    Text("Create List of Tasks")
                        .font(.largeTitle)
                        .frame(minWidth: 400, maxWidth: 400, minHeight: 5, maxHeight: 20)
                    
                    VStack {
                        NavigationStack {
                            List {
                                ForEach(tasks.indices, id: \.self) { index in
                                    HStack {
                                        Text("\(index+1). ")
                                        Text(tasks[index].name)
                                        Spacer()
                                        Text("\(tasks[index].time) Minutes")
                                    }
                                }
                                .onDelete(perform: deleteTask)
                            }
                        }
                        .frame(minWidth: 200, maxWidth: 400, minHeight: 220, maxHeight: 500)
                        
                        HStack {
                            TextField("Task Name", text: $newTaskName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width:190)
                            Stepper("\(newTaskTime) Minutes", value: $newTaskTime, in: 0...240, step: 5)
                                .frame(width:190)
                        }
                    }
                    .frame(width: 600)
                    .scrollContentBackground(.hidden)
                    
                    Button("Add Task") {
                        addTask()
                        if disableButton {
                            disableButton.toggle()
                        }
                    }
                    .frame(width: 200, height: 30, alignment: .center)
                    .background(.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                }
                Spacer()
                
                Button("Next") {
                    saveTasks()
                    showTask.toggle()
                    showSet.toggle()
                }
                .frame(width: 150, height: 40, alignment: .center)
                .background(disableButton ? .gray: .green)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(disableButton)
            }
        }
    }
    
    func addTask() {
         if !newTaskName.isEmpty {
             tasks.append(Todo(name: newTaskName, time: newTaskTime, done: false))
             newTaskName = ""
             newTaskTime = 30
         }
     }

     func deleteTask(at offsets: IndexSet) {
         tasks.remove(atOffsets: offsets)
     }
    
    func saveTasks () {
        let userdefaults = UserDefaults(suiteName: "group.com.mswendell.Kids-Tech-Balance.tasks")
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
    
    }


#Preview {
    mainMenu(showMenu: false, showTask: true, showSet: false, showUse: false, showReview: false)
        .environmentObject(DataModel())
}
