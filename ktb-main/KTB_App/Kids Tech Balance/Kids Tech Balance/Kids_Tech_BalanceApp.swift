//
//  Kids_Tech_BalanceApp.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 2/8/24.
//

import SwiftUI
import FamilyControls
import ManagedSettings


@main
struct Kids_Tech_BalanceApp: App {
    @State var showMenu = true
    @State var showTask = false
    @State var showSettings = false
    @State var showHistory = false
    @State var showSet = false
    @State var showUse = false
    @State var showReview = false
    
    let center = AuthorizationCenter.shared
    @StateObject var model = DataModel.shared
    @StateObject var store = ManagedSettingsStore()
    
    var body: some Scene {
        WindowGroup {
            VStack {}
                .onAppear {
                    Task {
                        do {
                            try await center.requestAuthorization(for: .individual)
                        } catch {
                            print("Failed to enroll with error: \(error)")
                        }
                    }
                }
            
            mainMenu(showMenu: true, showTask: false, showSet: false, showUse: false, showReview: false)
                .environmentObject(model)
                .environmentObject(store)
        }
    }
}




