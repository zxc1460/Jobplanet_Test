//
//  RecruitListCellType.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation

public struct RecruitList {
    public let count: Int
    public let sectionTitle: String
    public let recruits: [Recruit]
    
    public init(count: Int, sectionTitle: String, recruits: [Recruit]) {
        self.count = count
        self.sectionTitle = sectionTitle
        self.recruits = recruits
    }
}
