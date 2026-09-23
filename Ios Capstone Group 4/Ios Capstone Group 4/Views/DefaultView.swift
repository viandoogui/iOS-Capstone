//
//  DefaultView.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 9/22/26.
//
import SwiftUI

struct DefaultView: View {
    
    @State private var isLoggedIn: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    init(isLoggedIn: Bool) {
        self.isLoggedIn = isLoggedIn
    }
    
    var body: some View {
        Text("Hello, World!")
        Button("Log Out"){
            isLoggedIn = false
            dismiss()
        }
    }
}
