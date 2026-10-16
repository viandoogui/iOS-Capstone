//
//  DecodingHelpers.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/16/26.
//
import Foundation

func ApplyDateSettings(_ formatter: DateFormatter) {
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
}

func ConfigureNewDecoder(_ formatter: DateFormatter) -> JSONDecoder{
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(formatter)
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}
