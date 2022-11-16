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
    func toRecruitDetail()
}

class RecruitNavigator: RecruitNavigatorType {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toRecruitDetail() {
    }
}
