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
    case company(CompanyCellDTO)
    case recruit(RecruitCellDTO)
    case review(ReviewCellDTO)
    
    private enum CodingKeys: String, CodingKey {
        case type = "cell_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let singleContainer = try decoder.singleValueContainer()
        
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "CELL_TYPE_COMPANY":
            let company = try singleContainer.decode(CompanyCellDTO.self)
            self = .company(company)
        case "CELL_TYPE_HORIZONTAL_THEME":
            let recruit = try singleContainer.decode(RecruitCellDTO.self)
            self = .recruit(recruit)
        case "CELL_TYPE_REVIEW":
            let review = try singleContainer.decode(ReviewCellDTO.self)
            self = .review(review)
        default:
            fatalError("Unknown cell_type of content")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var singleContainer = encoder.singleValueContainer()
        
        switch self {
        case .company(let company):
            try singleContainer.encode(company)
        case .recruit(let recruit):
            try singleContainer.encode(recruit)
        case .review(let review):
            try singleContainer.encode(review)
        }
    }
}

extension CellTypeDTO: DomainConvertibleType {
    typealias `Type` = CellType
    
    func asDomain() -> CellType {
        switch self {
        case .recruit(let recruitList):
            return .recruitList(recruitList.asDomain())
        case .company(let company):
            return .company(company.asDomain())
        case .review(let review):
            return .review(review.asDomain())
        }
    }
}
