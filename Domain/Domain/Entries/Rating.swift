//
//  Rating.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/14.
//

import Foundation

public struct Rating {
    let type: String
    let rating: Double
    
    public init(type: String, rating: Double) {
        self.type = type
        self.rating = rating
    }
}
