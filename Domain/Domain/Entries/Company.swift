//
//  Company.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/14.
//

import Foundation

public struct Company: Codable {
    let name: String
    let logoURL: String
    let ratings: [Rating]
    
    private enum CodingKeys: String, CodingKey {
        case name, ratings
        case logoURL = "logo_path"
    }
}
