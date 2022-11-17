//
//  CompanyCellType.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation

public struct CompanyCellType {
    public let logoURL: String
    public let name: String
    public let industryName: String
    public let averageRating: Double
    public let reviewSummary: String
    public let interviewQuestion: String
    public let averageSalary: Int
    public let updateDate: Date
    
    public init(
        logoURL: String,
        name: String,
        industryName: String,
        averageRating: Double,
        reviewSummary: String,
        interviewQuestion: String,
        averageSalary: Int,
        updateDate: Date
    ) {
        self.logoURL = logoURL
        self.name = name
        self.industryName = industryName
        self.averageRating = averageRating
        self.reviewSummary = reviewSummary
        self.interviewQuestion = interviewQuestion
        self.averageSalary = averageSalary
        self.updateDate = updateDate
    }
}
