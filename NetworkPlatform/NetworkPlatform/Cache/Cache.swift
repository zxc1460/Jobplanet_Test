//
//  Cache.swift
//  NetworkPlatform
//
//  Created by Seok on 2022/11/14.
//

import Foundation
import RxSwift

protocol Caching {
    associatedtype KeyType
    associatedtype ValueType
    func save(key: KeyType, value: ValueType) -> Single<Void>
    func fetch(key: KeyType) -> Single<ValueType?>
}

final class Cache<K: Hashable, V>: Caching {
    typealias KeyType = K
    typealias ValueType = V
    
    private final class WrappedKey: NSObject {
        let key: K
        
        init(_ key: K) {
            self.key = key
        }
        
        override var hash: Int {
            return key.hashValue
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            
            return value.key == key
        }
    }
    
    private final class Entry {
        let value: V
        
        init(value: V) {
            self.value = value
        }
    }
    
    private let cacheScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "com.seok.Jobplanet-test.Cache.queue")
    private let wrapped = NSCache<WrappedKey, Entry>()
    
    func save(key: K, value: V) -> Single<Void> {
        return Single<Void>.create { [weak self] (observer) -> Disposable in
            let entry = Entry(value: value)
            
            self?.wrapped.setObject(entry, forKey: WrappedKey(key))
            
            observer(.success(()))
            
            return Disposables.create()
        }
        .subscribe(on: cacheScheduler)
    }
    
    func fetch(key: K) -> Single<V?> {
        return Single<V?>.create { [weak self] (observer) -> Disposable in
            let value = self?.wrapped.object(forKey: WrappedKey(key))?.value
            
            observer(.success(value))
            
            return Disposables.create()
        }
    }
}
