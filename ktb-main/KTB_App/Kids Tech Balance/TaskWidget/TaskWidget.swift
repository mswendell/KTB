//
//  TaskWidget.swift
//  TaskWidget
//
//  Created by Michael Wendell on 5/17/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), tasks: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), tasks: [Todo(name: "Youtube", time: 30, done: true)])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        var tasks: [Todo] = []
        
        let userdefaults = UserDefaults(suiteName: "group.com.mswendell.Kids-Tech-Balance.tasks")
        
        let names: [String] = userdefaults!.array(forKey: "taskNames") as? [String] ?? []
        let tasktimes: [Int] = userdefaults!.array(forKey: "taskTimes") as? [Int] ?? []
        let taskDone: [Bool] = userdefaults!.array(forKey: "taskDone") as? [Bool] ?? []
        
        for (index, _) in names.enumerated() {
            tasks.append(Todo(name: names[index], time: tasktimes[index], done: taskDone[index]))
        }
        
        let currentDate = userdefaults!.object(forKey: "enddate") as? Date ?? Date()
        
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, tasks: tasks)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var tasks: [Todo]
}

struct Todo {
    var name: String
    var time: Int
    var done: Bool
}

struct TaskWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        if entry.tasks.isEmpty {
            Text("Tap here to create a new KTB session!")
        }
        else  {
            VStack {
                Text("Task List:")
                Spacer()
                ForEach(entry.tasks.indices, id: \.self) { index in
                    HStack {
                        Text("\(index+1). ")
                        Text(entry.tasks[index].name)
                        Spacer()
                        Text("\(entry.tasks[index].time) Minutes")
                        Image(systemName: entry.tasks[index].done ? "checkmark.circle.fill" : "circle")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                }
                Spacer()
                HStack {
                    Text("Time Done:")
                    Text(entry.date, style: .time)
                }
                
            }
        }
    }
}

struct TaskWidget: Widget {
    let kind: String = "TaskWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                TaskWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TaskWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This widget will allow users to track tasks and mark them as complete.")
        .supportedFamilies([.systemLarge])
    }
}

#Preview(as: .systemLarge) {
    TaskWidget()
} timeline: {
    SimpleEntry(date: .now, tasks: [Todo(name: "Youtube", time: 30, done: false), Todo(name: "Youtube", time: 30, done: false), Todo(name: "Youtube", time: 30, done: false), Todo(name: "Youtube", time: 30, done: false), Todo(name: "Youtube", time: 30, done: false), Todo(name: "Youtube", time: 30, done: false), Todo(name: "Youtube", time: 30, done: false), Todo(name: "Youtube", time: 30, done: false)])
    SimpleEntry(date: .now, tasks: [Todo(name: "Youtube", time: 30, done: true)])
}
