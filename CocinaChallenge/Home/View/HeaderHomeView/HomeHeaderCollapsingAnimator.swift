//
//  HomeHeaderCollapsingAnimator.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 15/04/24.
//

import Foundation
import UIKit

protocol HomeHeaderCollapsingAnimatorDelegate {
    var heigthConstraint: NSLayoutConstraint {get set}
    var maxHeaderHeight: CGFloat {get set}
}

protocol HomeHeaderCollapsingAnimatorProtocol {
    func scrollViewDidScroll(offset: CGPoint)
    func scrolllViewBeging()
    func scrolllViewComplete()
}


final class HomeHeaderCollapsingAnimator: HomeHeaderCollapsingAnimatorProtocol {
    
    let heigthConstraint: NSLayoutConstraint
    private var maxHeaderHeight: CGFloat
    
    init(heigthConstraint: NSLayoutConstraint) {
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
    
    func scrolllViewComplete() {
        heigthConstraint.constant = 300
    }

}
extension HomeHeaderCollapsingAnimator {


}
