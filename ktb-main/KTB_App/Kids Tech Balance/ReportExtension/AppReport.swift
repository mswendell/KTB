//
//  AppReport.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 5/1/24.
//

import Foundation
import ManagedSettings

struct AppReport: Identifiable {
    
    var id: String
    var name: String
    var duration: TimeInterval
    var token: ApplicationToken
}

extension TimeInterval {
    
    func toString() -> String {
        let time = NSInteger(self)
        
        if time/3600 >= 1 {
            let minutes = (time / 60) % 60
            let hours = (time / 3600)
            if hours >= 2 {
                return String("\(hours) Hours \(minutes) Minutes")
            }
            else
            {
                return String("\(hours) Hour \(minutes) Minutes")
            }
        }
        else
        {
            let minutes = (time / 60)
            return String("\(minutes) Minutes")
        }
    }
    
}
