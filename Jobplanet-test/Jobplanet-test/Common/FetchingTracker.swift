//
//  FetchingTracker.swift
//  Jobplanet-test
//
//  Created by DoHyeong on 2022/11/17.
//

import Foundation
import RxSwift
import RxCocoa

public class FetchingTracker: SharedSequenceConvertibleType {
    public typealias Element = Bool
    public typealias SharingStrategy = DriverSharingStrategy
    
    private let lock = NSRecursiveLock()
    private let isFetching = BehaviorRelay<Bool>(value: false)
    private let loading: SharedSequence<SharingStrategy, Bool>
    
    public init() {
        loading = isFetching.asDriver()
            .distinctUntilChanged()
    }
    
    fileprivate func trackFetchingOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.Element> {
        return source.asObservable()
            .do(onNext: { _ in
                self.sendStopLoading()
            }, onError: { _ in
                self.sendStopLoading()
            }, onCompleted: {
                self.sendStopLoading()
            }, onSubscribe: subscribed)
    }
    
    private func subscribed() {
        lock.lock()
        isFetching.accept(true)
        lock.unlock()
    }
    
    private func sendStopLoading() {
        lock.lock()
        isFetching.accept(false)
        lock.unlock()
    }
    
    public func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        return loading
    }
}

extension ObservableConvertibleType {
    public func trackFetchinfg(_ activityIndicator: FetchingTracker) -> Observable<Element> {
        return activityIndicator.trackFetchingOfObservable(self)
    }
}
