//
//  CompanyNavigatoir.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation
import UIKit
import Domain

protocol CompanyNavigatorType: RecruitNavigatorType {
    func toInterview(_ interview: Interview)
}

final class CompanyNavigator: CompanyNavigatorType {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toInterview(_ interview: Interview) {
        let navigator = InterviewNavigator(navigationController: navigationController)
        let viewModel = InterviewViewModel(with: interview, navigator: navigator)
        let vc = InterviewViewController(viewModel: viewModel)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toRecruitDetail(_ recruit: Recruit) {
        let navigator = RecruitDetailNavigator(navigationController: navigationController)
        let viewModel = RecruitDetailViewModel(with: recruit, navigator: navigator)
        let vc = RecruitDetailViewController(viewModel: viewModel)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
