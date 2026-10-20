//
//  NetworkError.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 9/22/26.
//

enum NetworkError: Error {
    case invalidURL
    case noConnection
    case badResponse(statusCode: Int)
    case encodingFailed(underlying: Error)
    case decodingFailed(underlying: Error)
    case unauthorized
    case missingAuthToken
}

