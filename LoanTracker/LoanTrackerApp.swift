//
//  LoanTrackerApp.swift
//  LoanTracker
//
//  Created by David Kababyan on 04/06/2021.
//

import SwiftUI

@main
struct LoanTrackerApp: App {

    var body: some Scene {
        WindowGroup {
            LoansView()
                .environment(\.managedObjectContext, PersistenceController.shared.viewContext)
        }
    }
}
