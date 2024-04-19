//
//  GenericHeaderTableViewCell.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 18/04/24.
//

import UIKit

class GenericHeaderView: UIView {
    
    @IBOutlet weak var titleLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addRoundCorners(cornerRadius: 15)
        
    }

    
    func setupUI(title: String, enableBtn: Bool = false)  {
        self.titleLbl.text = title
    }

}
