//
//  ReviewCellDTO+Mapping.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation
import Domain

extension Review: DomainType {}

public struct ReviewDTO: Codable {
    let logoURL: String
    let name: String
    let industryName: String
    let averageRating: Double
    let reviewSummary: String
    let cons: String
    let pros: String
    let updateDate: Date
    
    private enum CodingKeys: String, CodingKey {
        case name, cons, pros
        case logoURL = "logo_path"
        case industryName = "industry_name"
        case averageRating = "rate_total_avg"
        case reviewSummary = "review_summary"
        case updateDate = "update_date"
    }
}


extension ReviewDTO: DomainConvertibleType {
    typealias `Type` = Review
    
    func asDomain() -> Review {
        return Review(
            logoURL: logoURL,
            name: name,
            industryName: industryName,
            averageRating: averageRating,
            reviewSummary: reviewSummary,
            cons: cons,
            pros: pros,
            updateDate: updateDate
        )
    }
}
