//
//  Recruit.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/14.
//

import Foundation

public struct Recruit {
    let id: Int
    let title: String
    let reward: Int
    let appeal: String
    let imageURL: String
    let company: Company
    
    public init(
        id: Int,
        title: String,
        reward: Int,
        appeal: String,
        imageURL: String,
        company: Company
    ) {
        self.id = id
        self.title = title
        self.reward = reward
        self.appeal = appeal
        self.imageURL = imageURL
        self.company = company
    }
}
