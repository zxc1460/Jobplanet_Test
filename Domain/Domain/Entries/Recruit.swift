//
//  Recruit.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/14.
//

import Foundation

public struct Recruit: Codable {
    let id: Int
    let title: String
    let reward: Int
    let appeal: String
    let imageURL: String
    let company: Company
    
    private enum CodingKeys: String, CodingKey {
        case id, title, reward, appeal, company
        case imageURL = "image_url"
    }
}
