//
//  EnvironmentExtensions.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 9/23/26.
//

import SwiftUI

extension EnvironmentValues {
    var isLoggedIn: Bool {
        get { self[IsLoggedInKey.self] }
        set { self[IsLoggedInKey.self] = newValue }
    }
}
