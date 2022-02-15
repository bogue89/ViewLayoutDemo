//
//  AssociatedFactory.swift
//  ViewLayout
//
//  Created by Jorge Benavides
//

import Foundation

public final class AssociatedFactory<T: AnyObject> {
    /// Accesses associated object.
    /// - Parameter associatedObject: An object whose associated object is to be accessed.
    /// - Parameter initializer: A clouser whose associated object is to be accessed.
    /// - Parameter policy: An association policy that will be used when linking objects.
    public func instance(_ associatedObject: AnyObject, initializer: (() -> T?)? = nil, policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) -> T? {
        if let instance = objc_getAssociatedObject(associatedObject, Unmanaged.passUnretained(self).toOpaque()) as! T? {
            return instance
        } else if let initializer = initializer, let instance = initializer() {
            objc_setAssociatedObject(associatedObject, Unmanaged.passUnretained(self).toOpaque(), instance, policy)
            return instance
        } else {
            return nil
        }
    }

}
