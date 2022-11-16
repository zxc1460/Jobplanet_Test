//
//  ObservableExtension.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/16.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    func catchErrorJustComplete() -> Observable<Element> {
        return self.catch { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
