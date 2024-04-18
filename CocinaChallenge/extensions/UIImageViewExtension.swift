//
//  UIImageViewExtension.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 14/04/24.
//

import Foundation
import UIKit


extension UIImageView {
    func downLoadImg(urlStr: String, contenMoe mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: urlStr) else { return }
        contentMode = mode
            self.showSqueleton()
        
        ImageRequestManager.shared.downloadImg(url: url) { image, error, onCache in
            DispatchQueue.main.async {
                if let _ = error {
                        self.image = UIImage(named: "App_Icon")
                    self.stopAnimating()
                } else if let image = image {
                        self.image = image
                    self.stopAnimating()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.image = UIImage(named: "App_Icon")
                        self.stopAnimating()
                    }
                }
            }
        }
    }
    
    
    func showSqueleton()  {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = 10

        
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 0.0
        animation.toValue = 0.9
        animation.duration = 0.79 // Duración de la animación
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        let randomDelay = Double.random(in: 0.0...0.5)
        animation.beginTime = CACurrentMediaTime() + randomDelay
        animation.repeatCount = .greatestFiniteMagnitude // Repetir la animación infinitamente
        animation.autoreverses = true // Revertir la animación automáticamente
        self.layer.add(animation, forKey: "animateOpacity")
        // Asignar la animación al gradiente

    }
    
    func stopAnimating(){
        DispatchQueue.main.async {
            self.layer.removeAllAnimations()
        }
    }
    


}


extension UIView {
    func addRoundCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        
    }

}
