//
//  StepsDishTableViewCell.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 18/04/24.
//

import UIKit

protocol StepsDishTableViewCellDelegate {
    func goToMapViewControler()
}

protocol SetupUITableViewCell{
    func setupUI(description: String, enableBtn: Bool)
    var viewContainer: StepsDishTableViewCellDelegate? {get set}

}

class StepsDishTableViewCell: UITableViewCell , SetupUITableViewCell {
    
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var descriptionLbl: UILabel!
    var viewContainer: StepsDishTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        locationBtn.backgroundColor = UIColor(named: "base_color_invertido")
        self.backgroundColor = UIColor(named: "base_color")
        locationBtn.titleLabel?.text = "Mapa"
        locationBtn.addRoundCorners(cornerRadius: 25)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(description: String, enableBtn: Bool) {
        self.descriptionLbl.text = description
        self.locationBtn.isHidden = !enableBtn
        setupActionBtn()
    }
    
    func setupActionBtn()  {
        locationBtn.addTarget(self, action: #selector(goToMap), for: .touchUpInside)
    }
    @objc func goToMap() {
        viewContainer?.goToMapViewControler()
    }
}
