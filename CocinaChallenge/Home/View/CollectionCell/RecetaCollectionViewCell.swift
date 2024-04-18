//
//  RecetaCollectionCollectionViewCell.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 15/04/24.
//

import UIKit

class RecetaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    
    static let identifier = "RecetaCollectionViewCell"
    
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImg.image = nil
        
    }
    
    func setupUI(name: String?, urlImg: String?){
        
        nameLbl.text = name ?? "Sin nombre"
        descriptionView.backgroundColor = UIColor.black.withAlphaComponent( 0.6)
        coverImg.downLoadImg(urlStr: urlImg ?? "")
        
    }
    
}
