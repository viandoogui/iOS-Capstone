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
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            
            NavigationLink(destination: OrderListView()) {
                Text("Order History")
            }
            
            Button("Log Out"){
                authStatus.updateLoginStatus(success: false)
            }
        }
    }
}
