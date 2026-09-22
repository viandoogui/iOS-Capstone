//
//  LoginModel.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 9/22/26.
//

import Foundation

struct LoginModel: Codable {
    
    var username: String = ""
    var password: String = ""
    
    enum CodingKeys: String, CodingKey {
        case username = "loginId"
        case password
    }
}
