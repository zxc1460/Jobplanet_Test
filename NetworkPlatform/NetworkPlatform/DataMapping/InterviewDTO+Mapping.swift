//
//  CompanyCellDTO.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation
import Domain

extension Interview: DomainType {}

public struct InterviewDTO: Codable {
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

extension InterviewDTO: DomainConvertibleType {
    typealias `Type` = Interview
    
    func asDomain() -> Interview {
        return Interview(
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
