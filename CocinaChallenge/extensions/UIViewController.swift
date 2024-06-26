//
//  UIViewController.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 15/04/24.
//

import Foundation
import UIKit


extension UIViewController {
    
    func add(child: UIViewController, container: UIView) {
        addChild(child)
        child.view.frame = container.bounds
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    func setViewDetents() {
        if #available(iOS 15.0, *){
            guard let sheet = self.sheetPresentationController else { return }
            sheet.detents = [.medium(),.large()]
            sheet.prefersGrabberVisible = false
        }
    }
}
