//
//  LauchScreenViewController.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 13/04/24.
//

import UIKit

class SplashViewController: UIViewController, Storyboarded, ViewProtocol {
    
    @IBOutlet weak var imgSplash: UIImageView!
    var presenter: SplashPresenterProtocol?
    func testView() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Secundarycolor")
        setup()
        processing()
        // Do any additional setup after loading the view.
        
    }

    deinit {
        print("Se borro splash")
    }
    
    func setup() {
        imgSplash.contentMode = .scaleAspectFill
        imgSplash.addRoundCorners(cornerRadius: 100)

        imgSplash.image = UIImage(named: "App_Icon")
    }
    

    
    // MARK: - Navigation
    
    func processing() {
        presenter?.processing()
       
    }


}

extension SplashViewController: SplashViewProtocol {
    func animatedIcon() {
        UIView.animate(withDuration: 0.7, animations: {[ weak self] in
            self?.imgSplash.transform = CGAffineTransform(scaleX: 5.8, y: 5.8)
        }) { (finish) in
            UIView.animate(withDuration: 0.5, animations:{
                self.imgSplash.transform = CGAffineTransform.identity
                self.imgSplash.alpha = 0.0
            }) { _ in
                self.presenter?.finishProcesing()
            }
        }
        
    }
    
    
}

    
    

