//
//  Company.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/14.
//

import Foundation

public struct Company {
    let name: String
    let logoURL: String
    let ratings: [Rating]
    
    public init(name: String, logoURL: String, ratings: [Rating]) {
        self.name = name
        self.logoURL = logoURL
        self.ratings = ratings
    }
}
