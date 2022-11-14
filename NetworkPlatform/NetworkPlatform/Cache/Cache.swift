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
    func save(key: KeyType, value: [ValueType]) -> Completable
    func fetch(key: KeyType) -> Maybe<[ValueType]>
}

final class Cache<K: Hashable, V: DomainType>: Caching {
    typealias KeyType = K
    typealias ValueType = V
    
    enum Error: Swift.Error {
        case save([V])
        case fetch(V.Type)
        case directoryNotFound
    }
    
    enum FileNames {
        static var objectsFileName: String {
            return "\(V.self)s.dat"
        }
    }
    
    private let path: String
    private let cacheScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "com.seok.Jobplanet-test.Cache.queue")
    
    init(path: String) {
        self.path = path
    }
    
    func save(key: K, value: [V]) -> Completable {
        return Completable.create { (observer) -> Disposable in
            guard let directoryURL = self.directoryURL() else {
                observer(.error(Error.directoryNotFound))
                return Disposables.create()
            }
            let path = directoryURL
                .appendingPathComponent(FileNames.objectsFileName)
            self.makeDirectoryIfNeeded(url: directoryURL)
            do {
                try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false).write(to: path)
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            
            return Disposables.create()
        }
        .subscribe(on: cacheScheduler)
    }
    
    func fetch(key: K) -> Maybe<[V]> {
        return Maybe<[V]>.create { (observer) -> Disposable in
            guard let directoryURL = self.directoryURL() else {
                observer(.completed)
                return Disposables.create()
            }
            let fileURL = directoryURL
                .appendingPathComponent(FileNames.objectsFileName)
            guard let objects = NSKeyedUnarchiver.unar as? [V] else {
                observer(.completed)
                return Disposables.create()
            }
            observer(MaybeEvent.success(objects.map { $0.asDomain() }))
                return Disposables.create()
        }.subscribe(on: cacheScheduler)
    }
    
    private func directoryURL() -> URL? {
        return FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(path)
    }
    
    private func makeDirectoryIfNeeded(url: URL) {
        do {
            try FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true
            )
        } catch {
            print("File: \(#file), function: \(#function)")
        }
    }
    
}
