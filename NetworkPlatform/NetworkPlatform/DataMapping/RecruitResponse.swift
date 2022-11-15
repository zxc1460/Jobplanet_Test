//
//  RecruitResponse.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/15.
//

import Foundation

public struct RecruitResponse: Codable {
    let recruitItems: [RecruitDTO]
    
    private enum CodingKeys: String, CodingKey {
        case recruitItems = "recruit_items"
    }
}
