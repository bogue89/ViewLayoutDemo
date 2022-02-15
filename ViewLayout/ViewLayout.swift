//
//  ViewLayout.swift
//  ViewLayout
//
//  Created by Jorge Benavides
//

import UIKit

public final class ViewLayout {
    
    private static var Factory = AssociatedFactory<ViewLayout>()

    public static func instance(for view: UIView) -> ViewLayout {
        Factory.instance(view, initializer: {
            ViewLayout(view)
        })!
    }

    /// view object to be constraint
    private unowned var view: UIView

    public init(_ view: UIView) {
        self.view = view
    }

    private var _constraints: [MutableConstraint] = []

    private func addConstraint<T: MutableConstraint>(_ constraint: T) -> T {
        guard !_constraints.contains(constraint) else { return constraint }
        _constraints.append(constraint)
        return constraint
    }

    public var constraints: [MutableConstraint] { _constraints }

    private lazy var _leading: HorizontalMutableConstraint = addConstraint(.init(item: view, attribute: .leading))
    private lazy var _leadingMargin: HorizontalMutableConstraint = addConstraint(.init(item: view, attribute: .leadingMargin))
    private lazy var _trailing: HorizontalMutableConstraint = addConstraint(.init(item: view, attribute: .trailing))
    private lazy var _trailingMargin: HorizontalMutableConstraint = addConstraint(.init(item: view, attribute: .trailingMargin))
    private lazy var _left: HorizontalMutableConstraint = addConstraint(.init(item: view, attribute: .left))
    private lazy var _leftMargin: HorizontalMutableConstraint = addConstraint(.init(item: view, attribute: .leftMargin))
    private lazy var _right: HorizontalMutableConstraint = addConstraint(.init(item: view, attribute: .right))
    private lazy var _rightMargin: HorizontalMutableConstraint = addConstraint(.init(item: view, attribute: .rightMargin))
    private lazy var _top: VerticalMutableConstraint = addConstraint(.init(item: view, attribute: .top))
    private lazy var _topMargin: VerticalMutableConstraint = addConstraint(.init(item: view, attribute: .topMargin))
    private lazy var _bottom: VerticalMutableConstraint = addConstraint(.init(item: view, attribute: .bottom))
    private lazy var _bottomMargin: VerticalMutableConstraint = addConstraint(.init(item: view, attribute: .bottomMargin))
    private lazy var _centerX: HorizontalMutableConstraint = addConstraint(.init(item: view, attribute: .centerX))
    private lazy var _centerXWithinMargins: HorizontalMutableConstraint = addConstraint(.init(item: view, attribute: .centerXWithinMargins))
    private lazy var _centerY: VerticalMutableConstraint = addConstraint(.init(item: view, attribute: .centerY))
    private lazy var _centerYWithinMargins: VerticalMutableConstraint = addConstraint(.init(item: view, attribute: .centerYWithinMargins))
    private lazy var _width: DimentionMutableConstraint = addConstraint(.init(item: view, attribute: .width))
    private lazy var _height: DimentionMutableConstraint = addConstraint(.init(item: view, attribute: .height))
    private lazy var _firstBaseline: VerticalMutableConstraint = addConstraint(.init(item: view, attribute: .firstBaseline))
    private lazy var _lastBaseline: VerticalMutableConstraint = addConstraint(.init(item: view, attribute: .lastBaseline))

    @discardableResult
    public func constraint(_ attribute: MutableConstraint.Attribute,
                    to foreignConstraint: MutableConstraint,
                    relation: MutableConstraint.Relation? = nil,
                    multiplier: CGFloat? = nil,
                    constant: CGFloat? = nil,
                    priority: UILayoutPriority? = nil,
                    active: Bool? = nil) -> MutableConstraint {

        constraint(attribute: attribute,
                   toItem: foreignConstraint.constraint.firstItem as? UIView,
                   toAttribute: foreignConstraint.constraint.firstAttribute,
                   relationBy: relation,
                   multiplier: multiplier,
                   constant: constant,
                   priority: priority,
                   active: active)
    }

    @discardableResult
    public func constraint(attribute: MutableConstraint.Attribute,
                    toItem: UIView? = nil,
                    toAttribute: MutableConstraint.Attribute = .notAnAttribute,
                    relationBy: MutableConstraint.Relation? = nil,
                    multiplier: CGFloat? = nil,
                    constant: CGFloat? = nil,
                    priority: UILayoutPriority? = nil,
                    active: Bool? = nil) -> MutableConstraint {

        let constraint = MutableConstraint(item: view,
                                           attribute: attribute,
                                           relatedBy: relationBy ?? .equal,
                                           toItem: toItem,
                                           toAttribute: toAttribute,
                                           multiplier: multiplier ?? 1,
                                           constant: constant ?? 0,
                                           priority: priority ?? .required)
        constraint.isActive = active ?? true
        return addConstraint(constraint)
    }

}


/// Easy attributed constraint access
extension ViewLayout {
    var leading: HorizontalMutableConstraint {
        get { _leading }
        set { _leading.constraint = newValue.constraint }
    }
    var leadingMargin: HorizontalMutableConstraint {
        get { _leading }
        set { _leading.constraint = newValue.constraint }
    }
    var trailing: HorizontalMutableConstraint {
        get { _trailing }
        set { _trailing.constraint = newValue.constraint }
    }
    var trailingMargin: HorizontalMutableConstraint {
        get { _trailingMargin }
        set { _trailingMargin.constraint = newValue.constraint }
    }
    var left: HorizontalMutableConstraint {
        get { _left }
        set { _left.constraint = newValue.constraint }
    }
    var leftMargin: HorizontalMutableConstraint {
        get { _leftMargin }
        set { _leftMargin.constraint = newValue.constraint }
    }
    var right: HorizontalMutableConstraint {
        get { _right }
        set { _right.constraint = newValue.constraint }
    }
    var rightMargin: HorizontalMutableConstraint {
        get { _rightMargin }
        set { _rightMargin.constraint = newValue.constraint }
    }
    var top: VerticalMutableConstraint {
        get { _top }
        set { _top.constraint = newValue.constraint }
    }
    var topMargin: VerticalMutableConstraint {
        get { _topMargin }
        set { _topMargin.constraint = newValue.constraint }
    }
    var bottom: VerticalMutableConstraint {
        get { _bottom }
        set { _bottom.constraint = newValue.constraint }
    }
    var bottomMargin: VerticalMutableConstraint {
        get { _bottomMargin }
        set { _bottomMargin.constraint = newValue.constraint }
    }
    var centerX: HorizontalMutableConstraint {
        get { _centerX }
        set { _centerX.constraint = newValue.constraint }
    }
    var centerXWithinMargins: HorizontalMutableConstraint {
        get { _centerXWithinMargins }
        set { _centerXWithinMargins.constraint = newValue.constraint }
    }
    var centerY: VerticalMutableConstraint {
        get { _centerY }
        set { _centerY.constraint = newValue.constraint }
    }
    var centerYWithinMargins: VerticalMutableConstraint {
        get { _centerYWithinMargins }
        set { _centerYWithinMargins.constraint = newValue.constraint }
    }
    var width: DimentionMutableConstraint {
        get { _width }
        set { _width.constraint = newValue.constraint }
    }
    var height: DimentionMutableConstraint {
        get { _height }
        set { _height.constraint = newValue.constraint }
    }
    var firstBaseline: VerticalMutableConstraint {
        get { _firstBaseline }
        set { _firstBaseline.constraint = newValue.constraint }
    }
    var lastBaseline: VerticalMutableConstraint {
        get { _lastBaseline }
        set { _lastBaseline.constraint = newValue.constraint }
    }

    //
    var leftTop: (`left`: HorizontalMutableConstraint, top: VerticalMutableConstraint) {
        get { (left, top) }
        set { left = newValue.0; top = newValue.1 }
    }
    var leftTopMargin: (leftMargin: HorizontalMutableConstraint, topMargin: VerticalMutableConstraint) {
        get { (leftMargin, topMargin) }
        set { leftMargin = newValue.0; topMargin = newValue.1 }
    }
    var leftBottom: (`left`: HorizontalMutableConstraint, bottom: VerticalMutableConstraint) {
        get { (left, bottom) }
        set { left = newValue.0; bottom = newValue.1 }
    }
    var leftBottomMargin: (leftMargin: HorizontalMutableConstraint, bottomMargin: VerticalMutableConstraint) {
        get { (leftMargin, bottomMargin) }
        set { leftMargin = newValue.0; bottomMargin = newValue.1 }
    }
    var rightTop: (`right`: HorizontalMutableConstraint, top: VerticalMutableConstraint) {
        get { (right, top) }
        set { right = newValue.0; top = newValue.1 }
    }
    var rightTopMargin: (rightMargin: HorizontalMutableConstraint, topMargin: VerticalMutableConstraint) {
        get { (rightMargin, topMargin) }
        set { rightMargin = newValue.0; topMargin = newValue.1 }
    }
    var rightBottom: (`right`: HorizontalMutableConstraint, bottom: VerticalMutableConstraint) {
        get { (right, bottom) }
        set { right = newValue.0; bottom = newValue.1 }
    }
    var rightBottomMargin: (rightMargin: HorizontalMutableConstraint, bottomMargin: VerticalMutableConstraint) {
        get { (rightMargin, bottomMargin) }
        set { rightMargin = newValue.0; bottomMargin = newValue.1 }
    }
    var leftRight: (`left`: HorizontalMutableConstraint, `right`: HorizontalMutableConstraint) {
        get { (left, right) }
        set { left = newValue.0; right = newValue.1 }
    }
    var leftRightMargin: (leftMargin: HorizontalMutableConstraint, rightMargin: HorizontalMutableConstraint) {
        get { (leftMargin, rightMargin) }
        set { leftMargin = newValue.0; rightMargin = newValue.1 }
    }
    var topBottom: (top: VerticalMutableConstraint, bottom: VerticalMutableConstraint) {
        get { (top, bottom) }
        set { top = newValue.0; bottom = newValue.1 }
    }
    var topBottomMargin: (topMargin: VerticalMutableConstraint, bottomMargin: VerticalMutableConstraint) {
        get { (topMargin, bottomMargin) }
        set { topMargin = newValue.0; bottomMargin = newValue.1 }
    }
    var position: (`left`: HorizontalMutableConstraint, top: VerticalMutableConstraint) {
        get { leftTop }
        set { leftTop = newValue }
    }
    var positionMargin: (leftMargin: HorizontalMutableConstraint, topMargin: VerticalMutableConstraint) {
        get { leftTopMargin }
        set { leftTopMargin = newValue }
    }
    var frame: (`left`: HorizontalMutableConstraint, top: VerticalMutableConstraint, `right`: HorizontalMutableConstraint, bottom: VerticalMutableConstraint) {
        get { (left, top, right, bottom) }
        set { left = newValue.0; top = newValue.1; right = newValue.2; bottom = newValue.3 }
    }
    var frameMargin: (leftMargin: HorizontalMutableConstraint, topMargin: VerticalMutableConstraint, rightMargin: HorizontalMutableConstraint, bottomMargin: VerticalMutableConstraint) {
        get { (leftMargin, topMargin, rightMargin, bottomMargin) }
        set { leftMargin = newValue.0; topMargin = newValue.1; rightMargin = newValue.2; bottomMargin = newValue.3 }
    }
    var center: (centerX: HorizontalMutableConstraint, centerY: VerticalMutableConstraint) {
        get { (centerX, centerY) }
        set { centerX = newValue.0; centerY = newValue.1 }
    }
    var centerWithinMargins: (centerXWithinMargins: HorizontalMutableConstraint, centerYWithinMargins: VerticalMutableConstraint) {
        get { (centerXWithinMargins, centerYWithinMargins) }
        set { centerXWithinMargins = newValue.0; centerYWithinMargins = newValue.1 }
    }
    var size: (width: DimentionMutableConstraint, height: DimentionMutableConstraint) {
        get { (width, height) }
        set { width = newValue.0; height = newValue.1 }
    }
}
