//
//  Recruit.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/14.
//

import Foundation

public struct Recruit {
    public let id: Int
    public let title: String
    public let reward: Int
    public let appeal: String
    public let imageURL: String
    public let company: Company
    
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
