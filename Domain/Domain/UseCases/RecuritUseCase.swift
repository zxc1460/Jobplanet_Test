//
//  RecuritUseCase.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/14.
//

import Foundation
import RxSwift

public protocol RecruitUseCase {
    func recruits() -> Observable<[Recruit]>
    func search(keyword: String) -> Observable<[Recruit]>
}
