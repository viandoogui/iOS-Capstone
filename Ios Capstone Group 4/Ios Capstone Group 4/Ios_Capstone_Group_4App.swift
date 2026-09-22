//
//  Ios_Capstone_Group_4App.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 9/21/26.
//

import SwiftUI
import CoreData

@main
struct Ios_Capstone_Group_4App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
