//
//  MutableConstraint.swift
//  ViewLayout
//
//  Created by Jorge Benavides
//

import UIKit

public class HorizontalMutableConstraint: MutableConstraint { }
public class VerticalMutableConstraint: MutableConstraint { }
public class DimentionMutableConstraint: MutableConstraint { }

public class MutableConstraint: Hashable {
    
    public static func == (lhs: MutableConstraint, rhs: MutableConstraint) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    public final func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }


    public typealias Attribute = NSLayoutConstraint.Attribute
    public typealias Relation = NSLayoutConstraint.Relation

    public convenience init(item: UIView,
                     attribute: Attribute,
                     relatedBy: Relation = .equal,
                     multiplier: CGFloat = 1,
                     constant: CGFloat = 0,
                     priority: UILayoutPriority = .defaultHigh) {

        self.init(item: item, attribute: attribute,
                  relatedBy: relatedBy,
                  toItem: item, toAttribute: attribute,
                  multiplier: multiplier,
                  constant: constant,
                  priority: priority)
    }

    public init(item firstItem: UIView,
         attribute firstAttribute: Attribute,
         relatedBy relation: Relation = .equal,
         toItem secondItem: UIView?,
         toAttribute secondAttribute: Attribute,
         multiplier: CGFloat = 1,
         constant: CGFloat = 0,
         priority: UILayoutPriority = .defaultHigh) {

        self.item = secondItem
        self.attribute = secondAttribute
        self.relation = relation
        self.multiplier = multiplier
        self.constant = constant
        self.priority = priority
        self._constraint = NSLayoutConstraint(item: firstItem,
                                              attribute: firstAttribute,
                                              relatedBy: relation,
                                              toItem: secondItem,
                                              attribute: secondAttribute,
                                              multiplier: multiplier,
                                              constant: constant)
    }

    private func resolveConstraint(item: UIView? = nil,
                                   attribute: Attribute? = nil,
                                   relation: Relation? = nil,
                                   multiplier: CGFloat? = nil,
                                   constant: CGFloat? = nil) -> NSLayoutConstraint {

        guard let firstItem = _constraint.firstItem as? UIView else {
            fatalError("trying to resolve unconfigured constraint")
        }
        let firstAttribute = _constraint.firstAttribute
        let relation = _constraint.relation
        var secondItem = (item ?? _constraint.secondItem) as? UIView
        let secondAttribute = attribute ?? _constraint.secondAttribute
        let multiplier = multiplier ?? _constraint.multiplier
        let constant = constant ?? _constraint.constant

        if constant != 0, firstItem == secondItem {
            if !(self is DimentionMutableConstraint) {
                secondItem = firstItem.superview
            } else if firstAttribute == secondAttribute {
                secondItem = nil
            }
        }

        return NSLayoutConstraint(item: firstItem,
                                  attribute: firstAttribute,
                                  relatedBy: relation,
                                  toItem: secondItem,
                                  attribute: secondAttribute,
                                  multiplier: multiplier,
                                  constant: constant)
    }

    private var _constraint: NSLayoutConstraint {
        willSet {
            _constraint.isActive = false
            newValue.priority = priority
            newValue.isActive = true
        }
    }

    public var constraint: NSLayoutConstraint {
        get {
            _constraint
        }
        set {
            guard let firstItem = constraint.firstItem else {
                fatalError("trying to satifying unconfigured constraint")
            }
            _constraint = NSLayoutConstraint(item: firstItem,
                                             attribute: constraint.firstAttribute,
                                             relatedBy: constraint.relation,
                                             toItem: newValue.firstItem,
                                             attribute: newValue.firstAttribute,
                                             multiplier: constraint.multiplier,
                                             constant: constraint.constant)
        }
    }

    public weak var item: UIView? {
        didSet {
            // Cannot assign to property: 'secondItem' is a get-only property
            //  constraint.secondItem = secondItem
            _constraint = resolveConstraint(item: item)
        }
    }

    public var attribute: Attribute {
        didSet {
            // Cannot assign to property: 'secondAttribute' is a get-only property
            //  constraint.secondAttribute = secondAttribute
            _constraint = resolveConstraint(attribute: attribute)
        }
    }

    public var relation: Relation {
        didSet {
            // Cannot assign to property: 'relation' is a get-only property
            // constraint.relation = relation
            _constraint = resolveConstraint(relation: relation)
        }
    }

    public var multiplier: CGFloat {
        didSet {
            // Cannot assign to property: 'multiplier' is a get-only property
            // constraint.multiplier = multiplier
            _constraint = resolveConstraint(multiplier: multiplier)
        }
    }

    public var constant: CGFloat {
        didSet {
            // Can assign property: 'constant' but we want to handle conflicts
            // constraint.constant = constant
            _constraint = resolveConstraint(constant: constant)
        }
    }

    public var isActive: Bool {
        get {
            _constraint.isActive
        }
        set {
            _constraint.isActive = newValue
        }
    }

    public var priority: UILayoutPriority {
        didSet {
            // Can assign property: 'priority' but we want to handle conflicts
            // constraint.priority = priority
            _constraint = resolveConstraint(constant: constant)
        }
    }

}

extension MutableConstraint {

    @discardableResult
    public func constraint(to foreignConstraint: MutableConstraint,
                    relation: Relation? = nil,
                    multiplier: CGFloat? = nil,
                    constant: CGFloat? = nil,
                    priority: UILayoutPriority? = nil,
                    active: Bool? = nil) -> MutableConstraint {

        constraint(item: foreignConstraint.item,
                   attribute: foreignConstraint.attribute,
                   relation: relation ?? foreignConstraint.relation,
                   multiplier: multiplier,
                   constant: constant,
                   priority: priority,
                   active: active)
    }

    @discardableResult
    public func constraint(item: UIView? = nil,
                    attribute: Attribute = .notAnAttribute,
                    relation: Relation? = nil,
                    multiplier: CGFloat? = nil,
                    constant: CGFloat? = nil,
                    priority: UILayoutPriority? = nil,
                    active: Bool? = nil) -> MutableConstraint {

        let view = self.constraint.firstItem as! UIView
        let constraint = MutableConstraint(item: view,
                                           attribute: self.constraint.firstAttribute,
                                           relatedBy: relation ?? .equal,
                                           toItem: item,
                                           toAttribute: attribute,
                                           multiplier: multiplier ?? 1,
                                           constant: constant ?? 0,
                                           priority: priority ?? .required)
        constraint.isActive = active ?? true
        return constraint
    }

}
