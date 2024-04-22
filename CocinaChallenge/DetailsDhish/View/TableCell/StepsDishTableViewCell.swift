//
//  StepsDishTableViewCell.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 18/04/24.
//

import UIKit

protocol StepsDishTableViewCellDelegate: AnyObject {
    func goToMapViewControler()
}

protocol SetupUITableViewCell: AnyObject{
    func setupUI(description: String, enableBtn: Bool)
    var viewContainer: StepsDishTableViewCellDelegate? {get set}

}

class StepsDishTableViewCell: UITableViewCell , SetupUITableViewCell {
    
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var descriptionLbl: UILabel!
    weak var viewContainer: StepsDishTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        locationBtn.addRoundCorners(cornerRadius: 25)
        locationBtn.backgroundColor = UIColor(named: "base_color_invertido")
        locationBtn.titleLabel?.text = ""
        self.backgroundColor = UIColor(named: "base_color")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
