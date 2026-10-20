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
    @StateObject var authStatus = AuthStatus()
    @State private var username: String = ""
    let urlBase = "https://api.bootcampcentral.com/api"
    var body: some Scene {
        WindowGroup {
            if authStatus.isLoggedIn {
                ContentView(urlBase: urlBase, username: username)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(authStatus)
            }
            else {
                LoginView()
                    .environmentObject(authStatus)
            }
           
        }
    }
}

