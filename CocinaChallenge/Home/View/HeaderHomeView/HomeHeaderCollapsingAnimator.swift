//
//  HomeHeaderCollapsingAnimator.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 15/04/24.
//

import Foundation
import UIKit



final class HomeHeaderCollapsingAnimator {
    private let headerView: UIView
     let heigthConstraint: NSLayoutConstraint
    
    private var maxHeaderHeight: CGFloat
    
    init(headerView: UIView, heigthConstraint: NSLayoutConstraint) {
        self.headerView = headerView
        self.heigthConstraint = heigthConstraint
        
        maxHeaderHeight = heigthConstraint.constant
    }
    
    func scrollViewDidScroll(offset: CGPoint) {
        let offsetY: CGFloat = offset.y 

        //dedo hacia arriba
        if offsetY > 50.0 {
            heigthConstraint.constant = 100
        } else if offsetY < 0 {
            let valuePos = offsetY * -1
            //dedo hacia abajo
            if valuePos > 50.0 {
                heigthConstraint.constant = 300
            }
        }
    }
    
    func scrolllViewBeging() {
        heigthConstraint.constant = 100

    }

}
extension HomeHeaderCollapsingAnimator {


}
