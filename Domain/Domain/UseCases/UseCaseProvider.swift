//
//  UseCaseProvider.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/14.
//

import Foundation

public protocol UseCaseProvider {
    
    func makeRecruitsUseCase() -> RecruitUseCase
}
