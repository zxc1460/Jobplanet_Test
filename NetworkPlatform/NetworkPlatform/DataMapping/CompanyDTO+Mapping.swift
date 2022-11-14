//
//  CompanyDTO+Mapping.swift
//  NetworkPlatform
//
//  Created by Seok on 2022/11/14.
//

import Foundation
import Domain

extension Company: DomainType {}

public struct CompanyDTO: Codable {
    let name: String
    let logoURL: String
    let ratings: [RatingDTO]
    
    private enum CodingKeys: String, CodingKey {
        case name, ratings
        case logoURL = "logo_path"
    }
}

extension CompanyDTO: DomainConvertibleType {
    typealias `Type` = Company
    
    func asDomain() -> Company {
        return Company(
            name: self.name,
            logoURL: self.logoURL,
            ratings: self.ratings.compactMap { $0.asDomain() }
        )
    }
}
