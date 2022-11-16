//
//  Company.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/14.
//

import Foundation

public struct Company {
    public let name: String
    public let logoURL: String
    public let ratings: [Rating]
    
    public init(name: String, logoURL: String, ratings: [Rating]) {
        self.name = name
        self.logoURL = logoURL
        self.ratings = ratings
    }
}
