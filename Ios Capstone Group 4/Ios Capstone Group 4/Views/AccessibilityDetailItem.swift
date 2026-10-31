//
//  AccessibilityDetailItem.swift
//  Ios Capstone Group 4
//
//  Created by user302959 on 10/30/26.
//
import SwiftUI

struct AccessibilityDetailItem: View {
    var fieldHeader: String
    var fieldBody: String
    var accessibilityLabel: String
    
    init(_ fieldHeader: String, _ fieldBody: String, _ accessibilityLabel: String) {
        self.fieldHeader = fieldHeader
        self.fieldBody = fieldBody
        self.accessibilityLabel = accessibilityLabel
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(fieldHeader)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(fieldBody)
                    .font(.body)
                
            }
            Text(" ")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(accessibilityLabel))
    }
}
