//
//  InterviewCellViewModel.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/17.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class InterviewCellViewModel: CellViewModelType {
    struct Input {
        let select: Driver<Void>
    }
    
    struct Output {
        let selectedInterview: Driver<Interview>
    }
    
    let interview: Interview
    private let navigator: CompanyNavigatorType
    
    init(with interview: Interview, navigator: CompanyNavigatorType) {
        self.interview = interview
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let selectedCompany = input.select
            .map {
                return self.interview
            }
            .do(onNext: navigator.toInterview)
                
        return Output(selectedInterview: selectedCompany)
    }
}

