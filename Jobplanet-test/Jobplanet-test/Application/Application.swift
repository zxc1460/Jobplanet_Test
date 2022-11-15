//
//  Application.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/15.
//

import Foundation
import Domain
import NetworkPlatform

final class Application {
    static let shared = Application()
    
    private let networkUseCaseProvider: Domain.UseCaseProvider
    
    private init() {
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }
}
