//
//  RecruitDetailNavigator.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/18.
//

import Foundation
import UIKit

protocol RecruitDetailNavigatorType {
}

final class RecruitDetailNavigator: RecruitDetailNavigatorType {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
