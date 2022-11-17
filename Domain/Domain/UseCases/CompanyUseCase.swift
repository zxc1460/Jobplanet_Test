//
//  CompanyUseCase.swift
//  Domain
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation
import RxSwift

public protocol CellUseCase {
    func cells() -> Observable<[CellType]>
    func search(keyword: String) -> Observable<[CellType]>
}
