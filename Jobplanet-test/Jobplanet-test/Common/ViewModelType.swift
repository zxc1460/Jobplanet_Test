//
//  ViewModelType.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/16.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
