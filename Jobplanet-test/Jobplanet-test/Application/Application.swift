//
//  Application.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/15.
//

import UIKit
import Foundation
import Domain
import NetworkPlatform

final class Application {
    static let shared = Application()
    
    private let networkUseCaseProvider: Domain.UseCaseProvider
    
    private init() {
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }
    
    func configureMainInterface(window: UIWindow) {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        
        let mainNavigator = MainNavigator(services: networkUseCaseProvider, navigationController: navigationController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        mainNavigator.toMain()
    }
}
