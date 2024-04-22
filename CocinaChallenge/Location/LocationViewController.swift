//
//  LocationViewController.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 18/04/24.
//

import UIKit

class LocationViewController: UIViewController, LocationViewDelegate, Storyboarded {
    
    var titleStr: String?
    var descriptionStr: String?
    var imgCoverStr: String?
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    deinit {
        print("Se elimina LocationViewController")
    }
    
    
    private func setupUI(){
        titleLbl.text = titleStr
        descriptionLbl.text = descriptionStr
        guard let imgCoverStr = imgCoverStr else { return }
        imgCover.downLoadImg(urlStr: imgCoverStr)
    }
    

}
protocol LocationViewDelegate {
    var titleStr: String? {get set}
    var descriptionStr: String? {get set}
    var imgCoverStr: String? {get set}
    
}

