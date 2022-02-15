//
//  ViewController.swift
//  ViewLayout
//
//  Created by Jorge Benavides
//

import UIKit

class BlueView: UIView {
    override var debugDescription: String {
        "blue view"
    }
}

class RedView: UIView {
    override var debugDescription: String {
        "red view"
    }
}
class ViewController: UIViewController {

    let center = UIView()

    var redView: RedView?

    var blueView: BlueView?

    var shouldLayout = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard shouldLayout else { return }

        redView = RedView()
        blueView = BlueView()

        [center, redView!, blueView!].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        center.backgroundColor = .gray
        redView?.backgroundColor = .red
        blueView?.backgroundColor = .blue


        center.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        center.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        center.widthAnchor.constraint(equalToConstant: 40).isActive = true
        center.heightAnchor.constraint(equalToConstant: 40).isActive = true

        redView?.bottomAnchor.constraint(equalTo: center.centerYAnchor).isActive = true
        redView?.rightAnchor.constraint(equalTo: center.leftAnchor).isActive = true
        redView?.widthAnchor.constraint(equalToConstant: 100).isActive = true
        redView?.heightAnchor.constraint(equalToConstant: 100).isActive = true

        guard let layout = blueView?.layout else { return }

        

        layout.top = center.layout.bottom

        layout.left = center.layout.centerX
        layout.left.relation = .greaterThanOrEqual
        layout.left.multiplier = 1.01
        layout.left.constant = 1

        layout.width = center.layout.width
//        layout.height.item = blueView
//        layout.height.attribute = .width
        layout.height = layout.width
//        layout.height.priority = .required
        layout.height.multiplier = 2

//
//        [30, 40, 60 , 100].forEach { minimunHight in
//            layout.constraint(.left, to: center.layout.centerX, relation: .equal, constant: minimunHight).priority = .defaultHigh
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print(blueView?.simulatedProperty?.view)
//        blueView?.removeFromSuperview()
//        blueView = nil
//        blueView?.layout.width.isActive = false
//        blueView?.layout.constraints[2].isActive = false

        guard !shouldLayout else { return }
        blueView?.layout.constraints.forEach { $0.isActive = false }
        view.layoutIfNeeded()
//        print("removing subviews")
//        view.subviews.forEach { $0.removeFromSuperview() }

//        redView.removeFromSuperview()
//        center.removeFromSuperview()
//        blueView.removeFromSuperview()

        let vc = ViewController()
        vc.shouldLayout = true
        self.present(vc, animated: true)

    }
}




