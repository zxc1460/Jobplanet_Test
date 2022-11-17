//
//  CompanyNavigatoir.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation
import UIKit
import Domain

protocol CompanyNavigatorType {
    func toCompanyDetail(_ company: CompanyCellType)
}

class CompanyNavigator: CompanyNavigatorType, RecruitNavigatorType {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toCompanyDetail(_ company: CompanyCellType) {
        print("회사 디테일로 이동\(company.name)")
    }
    
    func toRecruitDetail(_ recruit: Recruit) {
        print("채용 디테일로 이동 \(recruit.title)")
    }
}
