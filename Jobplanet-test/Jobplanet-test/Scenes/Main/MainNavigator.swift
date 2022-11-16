//
//  MainNavigator.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/16.
//

import UIKit
import Domain

protocol MainNavigatorType {
    func toRecruit()
    func toCompany()
}

class MainNavigator: MainNavigatorType {
    private let services: UseCaseProvider
    private let navigationController: UINavigationController
    
    init(services: UseCaseProvider, navigationController: UINavigationController) {
        self.services = services
        self.navigationController = navigationController
    }
    
    func toMain() {
        let vc = MainViewController()
        vc.viewModel = MainViewModel(navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toRecruit() {
        guard let mainViewController = navigationController.topViewController as? MainViewController else {
            return
        }
        
        removeChildViewController(mainViewController: mainViewController)
        
        let navigator = RecruitNavigator(navigationController: navigationController)
        let viewModel = RecruitViewModel(useCase: services.makeRecruitsUseCase(), navigator: navigator)
        let vc = RecruitViewController(viewModel: viewModel)
        
        mainViewController.childViewController = vc
        mainViewController.addChild(vc)
        mainViewController.contaierView.addSubview(vc.view)
        vc.view.frame = mainViewController.contaierView.bounds
        vc.didMove(toParent: mainViewController)
    }
    
    func toCompany() {
        guard let mainViewController = navigationController.topViewController as? MainViewController else {
            return
        }
        
        removeChildViewController(mainViewController: mainViewController)
        
        let vc = CompanyViewController()
        mainViewController.childViewController = vc
        mainViewController.addChild(vc)
        mainViewController.contaierView.addSubview(vc.view)
        vc.view.frame = mainViewController.contaierView.bounds
        vc.didMove(toParent: mainViewController)
    }
    
    func toRecruitDetail() {
    }
    
    private func removeChildViewController(mainViewController: MainViewController) {
        guard let childViewController = mainViewController.childViewController else {
            return
        }
        
        childViewController.willMove(toParent: nil)
        childViewController.removeFromParent()
        childViewController.view.removeFromSuperview()
    }
}
