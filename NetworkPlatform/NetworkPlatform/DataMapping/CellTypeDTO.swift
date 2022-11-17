//
//  CellTypeDTO.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation
import Domain

extension CellType: DomainType {}

enum CellTypeDTO: Codable {
    case interview(InterviewDTO)
    case recruitList(RecruitListDTO)
    case review(ReviewDTO)
    
    private enum CodingKeys: String, CodingKey {
        case type = "cell_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let singleContainer = try decoder.singleValueContainer()
        
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "CELL_TYPE_COMPANY":
            let interview = try singleContainer.decode(InterviewDTO.self)
            self = .interview(interview)
        case "CELL_TYPE_HORIZONTAL_THEME":
            let recruitList = try singleContainer.decode(RecruitListDTO.self)
            self = .recruitList(recruitList)
        case "CELL_TYPE_REVIEW":
            let review = try singleContainer.decode(ReviewDTO.self)
            self = .review(review)
        default:
            fatalError("Unknown cell_type of content")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var singleContainer = encoder.singleValueContainer()
        
        switch self {
        case .interview(let interview):
            try singleContainer.encode(interview)
        case .recruitList(let recruitList):
            try singleContainer.encode(recruitList)
        case .review(let review):
            try singleContainer.encode(review)
        }
    }
}

extension CellTypeDTO: DomainConvertibleType {
    typealias `Type` = CellType
    
    func asDomain() -> CellType {
//        switch self {
//        case .recruit(let recruitList):
//            return .recruitList(recruitList.asDomain())
//        case .company(let company):
//            return .company(company.asDomain())
//        case .review(let review):
//            return .review(review.asDomain())
//        }
        switch self {
        case .recruitList(let recruitList):
            return .recruitList(recruitList.asDomain())
        case .interview(let interview):
            return .interview(interview.asDomain())
        case .review(let review):
            return .review(review.asDomain())
        }
    }
}
