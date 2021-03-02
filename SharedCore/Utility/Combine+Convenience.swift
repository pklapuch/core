//
//  Combine+Convenience.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation
import Combine

public typealias CombineBag = Set<AnyCancellable>

extension Subscribers.Completion {
    
    public var hasSucceeded: Bool {
        
        switch self {
            
        case .finished: return true
        case .failure(_): return false
        }
    }
    
    public var error: Swift.Error? {
        
        switch self {
            
        case .finished: return nil
        case .failure(let error): return error
        }
    }
}

extension Publisher {
    
    public var erased: AnyPublisher<Output, Failure> { eraseToAnyPublisher() }
}

extension PassthroughSubject {
    
    public func sendValue(withDelay delay: Double, on: DispatchQueue, input: Output) {
        
        on.asyncAfter(deadline: .now() + delay) { [weak self] in self?.send(input) }
    }
}

extension PassthroughSubject where Output == Void {
    
    public func send(withDelay delay: Double, on: DispatchQueue) {
        
        on.asyncAfter(deadline: .now() + delay) { [weak self] in self?.send() }
    }
}

extension Future {
    
    public static func instantVoid() -> Future<Void, Swift.Error> {
        
        return Future<Void, Error> { promise in
            promise(.success(()))
        }
    }
    
    public static func instant<T>(value: T) -> Future<T, Swift.Error> {
        
        return Future<T, Error> { promise in
            promise(.success(value))
        }
    }
    
    public static func instant<T>(error: Swift.Error) -> Future<T, Swift.Error> {
        
        return Future<T, Error> { promise in
            promise(.failure(error))
        }
    }
    
    public static func switchTo(queue: DispatchQueue) -> Future<Void, Swift.Error> {
        
        return Future<Void, Error> { promise in
            queue.async {
                promise(.success(()))
            }
        }
    }
    
    public static func wait(_ interval: TimeInterval) -> Future<Void, Swift.Error> {
        return Future<Void, Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + interval) {
                promise(.success(()))
            }
        }
    }
}
