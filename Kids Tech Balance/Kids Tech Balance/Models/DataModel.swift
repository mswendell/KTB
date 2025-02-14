//
//  dataModel.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 4/14/24.
//

import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity

private let _DataModel = DataModel()

class DataModel: ObservableObject {
    let store = ManagedSettingsStore()
    @Published var activitySelection = FamilyActivitySelection()

    init() {
        activitySelection = FamilyActivitySelection(includeEntireCategory: true)
    }
    
    class var shared: DataModel {
        return _DataModel
    }
    
    func setShieldRestrictions() {
        print("shielding")
        let applications = DataModel.shared.activitySelection
        //store.shield.webDomains = applications.webDomainTokens.isEmpty ? nil : applications.webDomainTokens
        store.shield.webDomainCategories = .all()
        
        //store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
        //store.shield.applicationCategories = applications.categoryTokens.isEmpty ? nil : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
        store.shield.applicationCategories = .all(except: applications.applicationTokens)
        store.dateAndTime.requireAutomaticDateAndTime = true
        store.account.lockAccounts = true
        store.passcode.lockPasscode = true
        store.siri.denySiri = true
        store.appStore.denyInAppPurchases = true
        store.appStore.maximumRating = 200
        store.appStore.requirePasswordForPurchases = true
        store.media.denyExplicitContent = true
        store.gameCenter.denyMultiplayerGaming = true
        store.application.denyAppRemoval = true

    }
    
    func removesheildRestrictions () {
        store.clearAllSettings()
    }
}
