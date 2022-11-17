//
//  CustomDateDecodingStrategy.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation

enum CustomDateDecodingStrategy {

    private static let formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withTimeZone,
            .withFractionalSeconds
        ]
        return formatter
    }()

    static func decode(_ decoder: Decoder) throws -> Date {
        let container = try decoder.singleValueContainer()
        let dateStr = try container.decode(String.self)
        if let date = formatter.date(from: dateStr) {
            return date
        } else {
            throw NSError(domain: "date", code: -1, userInfo: nil)
        }
    }

}
