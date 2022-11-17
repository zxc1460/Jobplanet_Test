//
//  RecruitCellDTO.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation
import Domain

extension RecruitList: DomainType {}

public struct RecruitListDTO: Codable {
    let count: Int
    let sectionTitle: String
    let recruits: [RecruitDTO]
    
    private enum CodingKeys: String, CodingKey {
        case count
        case sectionTitle = "section_title"
        case recruits = "recommend_recruit"
    }
}

extension RecruitListDTO: DomainConvertibleType {
    typealias `Type` = RecruitList
    
    func asDomain() -> RecruitList {
        return RecruitList(
            count: count,
            sectionTitle: sectionTitle,
            recruits: recruits.map { $0.asDomain() }
        )
    }
}
