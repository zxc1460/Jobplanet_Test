//
//  Rating.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/14.
//

import Foundation

public struct Rating {
    public let type: String
    public let rating: Double
    
    public init(type: String, rating: Double) {
        self.type = type
        self.rating = rating
    }
}
