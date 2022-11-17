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
        print("인터뷰 디테일로 이동\(interview.name)")
    }
    
    func toRecruitDetail(_ recruit: Recruit) {
        print("채용 디테일로 이동 \(recruit.title)")
    }
}
