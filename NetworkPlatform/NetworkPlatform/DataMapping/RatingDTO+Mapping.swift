//
//  RatingDTO.swift
//  NetworkPlatform
//
//  Created by Seok on 2022/11/14.
//

import Foundation
import Domain

extension Rating: DomainType {}

public struct RatingDTO: Codable {
    let type: String
    let rating: Double
}

extension RatingDTO: DomainConvertibleType {
    typealias `Type` = Rating
    
    func asDomain() -> Rating {
        return Rating(type: self.type, rating: self.rating)
    }
}
