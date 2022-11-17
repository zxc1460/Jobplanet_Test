//
//  ReviewCellType.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation

public struct ReviewCellType {
    public let logoURL: String
    public let name: String
    public let industryName: String
    public let averageRating: Double
    public let reviewSummary: String
    public let cons: String
    public let pros: String
    public let updateDate: Date
    
    public init(
        logoURL: String,
        name: String,
        industryName: String,
        averageRating: Double,
        reviewSummary: String,
        cons: String,
        pros: String,
        updateDate: Date
    ) {
        self.logoURL = logoURL
        self.name = name
        self.industryName = industryName
        self.averageRating = averageRating
        self.reviewSummary = reviewSummary
        self.cons = cons
        self.pros = pros
        self.updateDate = updateDate
    }
}
