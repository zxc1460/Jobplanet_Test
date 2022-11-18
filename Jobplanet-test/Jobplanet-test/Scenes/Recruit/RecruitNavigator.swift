//
//  RecruitNavigator.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/17.
//

import Foundation
import UIKit
import Domain

protocol RecruitNavigatorType {
    func toRecruitDetail(_ recruit: Recruit)
}

final class RecruitNavigator: RecruitNavigatorType {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toRecruitDetail(_ recruit: Recruit) {
        let navigator = RecruitDetailNavigator(navigationController: navigationController)
        let viewModel = RecruitDetailViewModel(with: recruit, navigator: navigator)
        let vc = RecruitDetailViewController(viewModel: viewModel)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
