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
    let userName: String = ""
    
    var body: some View {
        VStack {
            NavigationLink(destination: LoginView()) {
                Text("Log In")
            }
            
            Button("Log Out"){
                authStatus.logOut()
            }
        }
        
        //Button to take you to product view
//        NavigationLink(destination: ProductListView()){
//            Text("Product List")
//        }
        
        
    }
}
