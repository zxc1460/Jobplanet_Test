//
//  InterviewViewModel.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/18.
//

import Foundation
import Domain

final class InterviewViewModel: ViewModelType {
    typealias Input = Void
    typealias Output = Void
    
    let interview: Interview
    private let navigator: InterviewNavigatorType
    
    init(with interview: Interview, navigator: InterviewNavigatorType) {
        self.interview = interview
        self.navigator = navigator
    }
    
    func transform(input: Void = ()) -> Void {
        return
    }
}
