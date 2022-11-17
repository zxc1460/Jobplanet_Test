//
//  CompanyCellDTO.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation
import Domain

extension CompanyCellType: DomainType {}

public struct CompanyCellDTO: Codable {
    let logoURL: String
    let name: String
    let industryName: String
    let averageRating: Double
    let reviewSummary: String
    let interviewQuestion: String
    let averageSalary: Int
    let updateDate: Date
    
    private enum CodingKeys: String, CodingKey {
        case name
        case logoURL = "logo_path"
        case industryName = "industry_name"
        case averageRating = "rate_total_avg"
        case reviewSummary = "review_summary"
        case interviewQuestion = "interview_question"
        case averageSalary = "salary_avg"
        case updateDate = "update_date"
    }
}

extension CompanyCellDTO: DomainConvertibleType {
    typealias `Type` = CompanyCellType
    
    func asDomain() -> CompanyCellType {
        return CompanyCellType(
            logoURL: logoURL,
            name: name,
            industryName: industryName,
            averageRating: averageRating,
            reviewSummary: reviewSummary,
            interviewQuestion: interviewQuestion,
            averageSalary: averageSalary,
            updateDate: updateDate
        )
    }
}
