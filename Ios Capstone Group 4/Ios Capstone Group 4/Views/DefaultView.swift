//
//  DefaultView.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 9/22/26.
//
import SwiftUI

struct DefaultView: View {
    @EnvironmentObject var authStatus: AuthStatus
    @Environment(\.dismiss) private var dismiss
    let urlBase = "https://api.bootcampcentral.com/api"

    
    var body: some View {
        VStack {
            Text("Hello, World!")
            
            Button("Log Out"){
                authStatus.updateLoginStatus(success: false)
            }
        }
        
        //Button to take you to product view
        NavigationLink(destination: InventoryListView(repository: RemoteInventoryRepository(urlBase: urlBase, authStatus: authStatus))){
            Text("Inventory List")
        }
        
        
    }
}
