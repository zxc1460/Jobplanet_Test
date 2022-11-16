//
//  RecruitCellViewModel.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/16.
//

import Foundation
import Domain

final class RecruitCellViewModel {
    let recruit: Recruit
    
    init(with recruit: Recruit) {
        self.recruit = recruit
    }
}
