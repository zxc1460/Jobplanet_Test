//
//  CellResponse.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation

public struct CellResponse: Codable {
    let cellItems: [CellTypeDTO]
    
    private enum CodingKeys: String, CodingKey {
        case cellItems = "cell_items"
    }
}
