//
//  FlyweightFactory.swift
//  ViewLayout
//
//  Created by Jorge Benavides
//

import Foundation

protocol FlyweightFactory {
    associatedtype SingletonType = AnyObject
    typealias Builder = () -> SingletonType?
    /// Private array for singleton paird with view
    static var instances: [ObjectIdentifier : SingletonType] { get set }
    /// Public access to singleton for identifier
    static func instance(for identifier: ObjectIdentifier?, initializer: Builder?) -> SingletonType?
    /// Remove the instance from the array releasing it from memory
    static func destroy(with identifier: ObjectIdentifier)
}

extension FlyweightFactory {
    /// Retrieves or initialize a singleton for identifier
    public static func instance(for identifier: ObjectIdentifier? = nil, initializer: Builder? = nil) -> SingletonType? {

        let id = identifier ?? ObjectIdentifier(self)

        if let instance = Self.instances[id] {
            return instance
        } else if let initializer = initializer, let instance = initializer() {
            Self.instances[id] = instance
            return instance
        } else {
            return nil
        }
    }
    /// Remove the instance from the array releasing it from memory
    /// warning: this operation (as many) is not thread safe, use syncronized methods for exaustive use of instances
    public static func destroy(with identifier: ObjectIdentifier) {
        Self.instances.removeValue(forKey: identifier)
    }
}
