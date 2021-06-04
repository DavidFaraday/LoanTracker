//
//  LoanTrackerApp.swift
//  LoanTracker
//
//  Created by David Kababyan on 04/06/2021.
//

import SwiftUI

@main
struct LoanTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
