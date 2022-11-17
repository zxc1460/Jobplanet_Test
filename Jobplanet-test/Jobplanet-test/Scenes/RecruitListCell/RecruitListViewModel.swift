//
//  RecruitListViewModel.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/18.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class RecruitListViewModel: CellViewModelType {
    struct Input {}
    
    struct Output {
        let items: Driver<[RecruitCellViewModel]>
    }
    
    let recruitList: RecruitList
    private let navigator: RecruitNavigatorType
    
    init(with recruitList: RecruitList, navigator: RecruitNavigatorType) {
        self.recruitList = recruitList
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let items = Observable.just(recruitList.recruits)
            .map { recruits -> [RecruitCellViewModel] in
                return recruits.map {
                    return RecruitCellViewModel(with: $0, navigator: self.navigator)
                }
            }
            .asDriverOnErrorJustComplete()
        
        
        return Output(items: items)
    }
}
