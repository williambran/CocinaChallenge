//
//  QueryListTableViewController.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 15/04/24.
//

import UIKit

class DetailsDishViewController: UIViewController, Storyboarded, ViewProtocol {
    
    var presenter: DetailsDishPresenterProtocol?
    var dataSource: DishesDTO?
    
    weak var headerWeak: GenericHeaderView?
    weak var descriptionCell: StepsDishTableViewCell?

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerImg: UIImageView!
   


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "base_color")
        navigationController?.isNavigationBarHidden = false
        dataSource = presenter?.dataRecipes
        setuoUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setuoUI() {
        setupCoverImg()
        setupTableView()
    }

    // MARK: - Table view data source
    lazy var tableView: UITableView = { [weak self] in
       var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func setupTableView() {
        containerView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        tableView.backgroundColor = UIColor(named: "base_color")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        let UInib = UINib(nibName: StepsDishTableViewCell.reuseIdentifier, bundle: .main)
        tableView.register(UInib, forCellReuseIdentifier: StepsDishTableViewCell.reuseIdentifier)
        tableView.reloadData()
    }
    
    // MARK: - UIImageView
    func setupCoverImg() {
        containerImg.downLoadImg(urlStr: dataSource?.urlImg ?? "")
        containerImg.addRoundCorners(cornerRadius: 20)
        
    }


}
extension DetailsDishViewController: DetailsDishViewProtocol {
    
}

extension DetailsDishViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numberSections = 1
        if let ingredientes = dataSource?.ingredients, !ingredientes.isEmpty {
            numberSections += 1
        }
        if let steps = dataSource?.preparationSteps,  !steps.isEmpty {
            numberSections += 1
        }
        return numberSections
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            dataSource?.description != nil ? 1 : 0
        } else if section == 1 {
            dataSource?.ingredients?.count ?? 0
        } else {
            dataSource?.preparationSteps?.count  ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellQ: UITableViewCell = UITableViewCell()
        weak var cell = cellQ
        cell?.backgroundColor = UIColor(named: "base_color")
        cell?.textLabel?.numberOfLines = 0
        var allData: [String] = []

        if  indexPath.section == 0 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StepsDishTableViewCell.reuseIdentifier) as? StepsDishTableViewCell else {return  UITableViewCell()}
            descriptionCell = cell
            descriptionCell?.setupUI(description: dataSource?.description ?? "Sin descripcion", enableBtn: true)
            descriptionCell?.viewContainer = self
            return descriptionCell!
        } else if indexPath.section == 1 {
            allData = dataSource?.ingredients ?? []
            cell?.textLabel?.text = " ●  \(allData[indexPath.row])"
        } else {
            allData = dataSource?.preparationSteps ?? []
            cell?.textLabel?.text = "\(indexPath.row).-  \(allData[indexPath.row])"
        }
        return cell!

    }
    //dise;o de headers
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = UINib(nibName: GenericHeaderView.reuseIdentifier, bundle: .main).instantiate(withOwner: nil, options: nil).first as? GenericHeaderView else { return nil }
        headerWeak = header
        var titleStr = "oro"
        if section == 0 {
            titleStr = "Acerca de la receta"
        } else if section == 1 {
            titleStr = "Ingredientes"
        } else {
            titleStr = "Pasos de preparacion"
        }
        headerWeak?.setupUI(title: titleStr, enableBtn: section == 0 ? true : false)
        return headerWeak
    }
    
    
}
extension DetailsDishViewController: StepsDishTableViewCellDelegate {
    func goToMapViewControler() {
        presenter?.gotToMapView(data: dataSource?.origin)
    }
    
    
}
