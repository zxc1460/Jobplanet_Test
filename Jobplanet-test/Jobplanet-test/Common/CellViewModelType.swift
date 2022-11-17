//
//  CellViewModelType.swift
//  Jobplanet-test
//
//  Created by Seok on 2022/11/17.
//

import Foundation

class CellViewModelType: ViewModelType {
    struct Input {}
    
    struct Output {}
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
