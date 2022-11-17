//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by DoHyeong on 2022/11/15.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    private let networkProvider: NetworkProvider
    
    public init() {
        self.networkProvider = NetworkProvider()
    }
    
    public func makeRecruitsUseCase() -> Domain.RecruitUseCase {
        return RecruitUseCase(network: networkProvider.makeRecruitsNetwork(), cache: Cache<String, RecruitResponse>())
    }
    
    public func makeCellUseCase() -> Domain.CellUseCase {
        return CellUseCase(network: networkProvider.makeCellNetwork(), cache: Cache<String, CellResponse>())
    }
}
