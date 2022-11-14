//
//  RecruitDTO+Mapping.swift
//  NetworkPlatform
//
//  Created by Seok on 2022/11/14.
//

import Foundation
import Domain

extension Recruit: DomainType {}

public struct RecruitDTO: Codable {
    let id: Int
    let title: String
    let reward: Int
    let appeal: String
    let imageURL: String
    let company: CompanyDTO
    
    private enum CodingKeys: String, CodingKey {
        case id, title, reward, appeal, company
        case imageURL = "image_url"
    }
}

extension RecruitDTO: DomainConvertibleType {
    typealias `Type` = Recruit
    
    func asDomain() -> Recruit {
        return Recruit(
            id: self.id,
            title: self.title,
            reward: self.reward,
            appeal: self.appeal,
            imageURL: self.imageURL,
            company: self.company.asDomain()
        )
    }
}
