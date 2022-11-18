//
//  InterviewNavigator.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/18.
//

import UIKit

protocol InterviewNavigatorType {
}

final class InterviewNavigator: InterviewNavigatorType {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
