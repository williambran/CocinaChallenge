//
//  HomeScreenViewController.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 14/04/24.
//

import UIKit
import Foundation

class HomeScreenViewController: UIViewController, Storyboarded, ViewProtocol {

    
    typealias ReloadData = () -> Void
    var reloadCallback: ReloadData?
    var presenter: HomeScreenPresenter?
    private var headerAnimator: HomeHeaderCollapsingAnimator?
    var dataSource: [DishesDTO] = []
    var searchingData: [DishesDTO] = []
   // var searchingDataSet: Set<DishesDTO> = Set()
    var searchingFlag: Bool = false
       
    @IBOutlet  weak   var headerView: UIView!
    @IBOutlet  private(set)  var contenListView: UIView!
    @IBOutlet  weak var headerConstraint: NSLayoutConstraint?
    @IBOutlet weak var resultSearchLbl: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    let widthScreen = UIScreen.main.bounds.width
    var numberOfColumns: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getListRecetas()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { context in
            // Aquí puedes realizar acciones específicas mientras la transición está en curso
            // Por ejemplo, ajustar el diseño de tus vistas
            self.homeHeaderView.actualizarComponentes()
        }) { context in
            // Aquí puedes realizar acciones específicas después de que la transición haya finalizado
            // Por ejemplo, actualizar datos o recargar vistas
        }
    }
    lazy var collectionView: UICollectionView = {
       var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let spacing: CGFloat = 10
        let totalSpacing = (numberOfColumns) * spacing
        let itemWith = (widthScreen - totalSpacing) / numberOfColumns
        layout.itemSize = CGSize(width: itemWith, height: itemWith + 5)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
        collection.isPagingEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var tableView: UITableView = {
       var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var homeHeaderView: HomeHeaderView = {
        var homeHeaderView = HomeHeaderView()
        homeHeaderView.viewC = self
        homeHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return homeHeaderView
    }()
    
    func setup() {
        numberOfColumns = widthScreen > 500 ? 3: 2
        navigationController?.isNavigationBarHidden = true
        self.headerConstraint?.isActive = true
        activarViewHeader()
        setupHeader()
        //setupTableView()
        setupCollectionView()
        setupHeaderAnimation()
        tableView.reloadData()
        reloadCallback = { [weak self] in
            if let dataSource = self?.dataSource , dataSource.isEmpty {
                self?.collectionView.isHidden = true
                self?.loading.stopAnimating()
                self?.loading.isHidden = true
                self?.resultSearchLbl.text = "Sin resultados"
            } else {
                self?.collectionView.isHidden = false
                self?.loading.stopAnimating()
                self?.loading.isHidden = false
                self?.resultSearchLbl.text = ""
            }
        }
        
    }
    
    func setupHeader() {
       // homeHeaderView.backgroundColor = UIColor.red
        self.headerView.addSubview(homeHeaderView)
        NSLayoutConstraint.activate([
            homeHeaderView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            homeHeaderView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            homeHeaderView.topAnchor.constraint(equalTo: headerView.topAnchor),
            homeHeaderView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        homeHeaderView.setupUI()
    }
    
    func setupCollectionView() {
        contenListView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contenListView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contenListView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contenListView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contenListView.bottomAnchor)
        ])
        let collectionCell = UINib(nibName: RecetaCollectionViewCell.reuseIdentifier, bundle: .main)
        collectionView.register(collectionCell, forCellWithReuseIdentifier: RecetaCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        reloadDataCompletion {
            if  self.dataSource.isEmpty {
                self.collectionView.isHidden = true
            } else {
                self.collectionView.isHidden = false
            }
        }
        
    }
    
    func setupTableView() {
        contenListView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: contenListView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contenListView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: contenListView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: contenListView.bottomAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func setupHeaderAnimation() {
        headerAnimator = HomeHeaderCollapsingAnimator(headerView: headerView, heigthConstraint: headerConstraint!)
    }
    
    func activarViewHeader() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func reloadDataCompletion(completion: @escaping()->Void) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            completion()
        }
    }
    
    func enableLoading() {
        if dataSource.isEmpty {
            collectionView.isHidden = true
        } else {
            collectionView.isHidden = false
        }
    }
}
extension HomeScreenViewController: HomeScreenViewProtocol {
    func loadData(dishes: [DishesDTO]) {
        self.dataSource = dishes
        //self.searchingDataSet = Set(dishes)
        reloadDataCompletion {
            if self.dataSource.isEmpty {
                self.collectionView.isHidden = true
            } else {
                self.collectionView.isHidden = false
            }
        }
        
    }
}

extension HomeScreenViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard  scrollView.contentOffset.y != (contenListView.frame.origin.y * -1) else { return  }
        UIView.animate(withDuration: 0.4, animations: {[ weak self] in
            self?.headerAnimator?.scrollViewDidScroll(offset: scrollView.contentOffset)
            self?.view.layoutIfNeeded()
        })
    }
}

extension HomeScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataSource[indexPath.row].name
        return cell
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegate {
    
}

extension HomeScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellReusable = collectionView.dequeueReusableCell(withReuseIdentifier: RecetaCollectionViewCell.reuseIdentifier, for: indexPath) as? RecetaCollectionViewCell
        guard let cell = cellReusable else { return UICollectionViewCell() }
        cell.setupUI(name: dataSource[indexPath.row].name, urlImg: dataSource[indexPath.row].urlImg)
        cell.addRoundCorners(cornerRadius: 15)
        return cell
    }
    
}
extension HomeScreenViewController: HomeHeaderDelegate {
    func searchFast(_ query: String?) {
        
    }
    
    func begingSearch() {
        searchingData = dataSource
        UIView.animate(withDuration: 0.15, animations: {[ weak self] in

            self?.headerAnimator?.scrolllViewBeging()
            self?.view.layoutIfNeeded()
        }) { (finish)  in
            self.tableView.isHidden = true
        }
    }
    
    func search(_ query: String?) {
        guard let query = query, !searchingFlag else { return }
        self.searchingFlag = true
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline:  .now() + 3) { [weak self] in
            guard let searching = self?.searchingFlag, searching else {return}
            self?.searchingFlag = false
            let dish = self?.searchingData.filter{$0.name?.range(of: query, options: .caseInsensitive) != nil}
            if let data = dish, !data.isEmpty {
                self?.dataSource = data
            } else {
                self?.dataSource = []
            }
                self?.reloadDataCompletion { [weak self] in
                    self?.reloadCallback?()
                }
        }
            self.reloadDataCompletion { [weak self] in
                self?.collectionView.isHidden = true
                self?.loading.startAnimating()
                self?.loading.isHidden = false
                self?.resultSearchLbl.text = "Buscando..."
        }
    }
    
    func didCancelSearch() {
        dataSource = searchingData
        reloadDataCompletion { [weak self] in
            if let dataSsource = self?.dataSource, dataSsource.isEmpty {
                self?.collectionView.isHidden = true
            } else {
                self?.collectionView.isHidden = false
            }
        }
    }
    
    
}

