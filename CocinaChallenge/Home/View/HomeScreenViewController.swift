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
    var headerAnimator: HomeHeaderCollapsingAnimatorProtocol?
    var dataSource: [DishesDTO] = []
    var searchingData: [DishesDTO] = []
    var searchingDataSet: Set<DishesDTO> = Set()
    var searchingFlag: Bool = false
    var textSearched = ""
    var statusSearch: searchStatus = .INACTIVE
    
    //weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var contenListView: UIView!
    @IBOutlet weak var headerConstraint: NSLayoutConstraint?
    @IBOutlet weak var resultSearchLbl: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "base_color")
        setup()
        presenter?.getListRecetas()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        collectionView.reloadData()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { context in
            self.homeHeaderView.actualizarComponentes()
        }) { context in
        }
    }

    let widthScreen = UIScreen.main.bounds.width
    var numberOfColumns: CGFloat = 0
    
    lazy var collectionView: UICollectionView = { [weak self] in
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
    
 
    
    lazy var homeHeaderView = { [weak self] in
        var homeHeaderView = HomeHeaderView()
        homeHeaderView.viewC = self
        homeHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return homeHeaderView
    }()
    
    func setup() {
        numberOfColumns = widthScreen > 500 ? 3: 2
        self.headerConstraint?.isActive = true
        activarViewHeader()
        setupHeader()
        setupCollectionView()
        setupHeaderAnimation()
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
        collectionView.backgroundColor =  UIColor(named: "base_color")
        reloadDataCompletion { [weak self] in
            if  ((self?.dataSource.isEmpty) != nil) {
                self?.collectionView.isHidden = true
            } else {
                self?.collectionView.isHidden = false
            }
        }
        
    }
    
    func setupHeaderAnimation() {
        headerAnimator = HomeHeaderCollapsingAnimator( heigthConstraint: headerConstraint!)
    }
    
    func activarViewHeader() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func reloadDataCompletion(completion: @escaping()->Void) {
        DispatchQueue.main.async { [weak self] in
            completion()
            self?.collectionView.reloadData()
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
        if self.dataSource.isEmpty {
            self.collectionView.isHidden = true
        }else {
            self.collectionView.isHidden = false
        }
        self.collectionView.reloadData()
    }
}



extension HomeScreenViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard  scrollView.contentOffset.y != (contenListView.frame.origin.y * -1) else { return  }
        UIView.animate(withDuration: 0.4, animations: {[ weak self] in
            self?.headerAnimator?.scrollViewDidScroll(offset: scrollView.contentOffset)
            self?.view.layoutIfNeeded()
        })
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeHeaderView.deselected()
        textSearched = homeHeaderView.getSearchText() ?? ""
        presenter?.goDetails(dataSource[indexPath.row])
        
    }
}

extension HomeScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        weak var cell: RecetaCollectionViewCell?
        let cellReusable = collectionView.dequeueReusableCell(withReuseIdentifier: RecetaCollectionViewCell.reuseIdentifier, for: indexPath) as? RecetaCollectionViewCell
        cell = cellReusable
        cell?.setupUI(name: dataSource[indexPath.row].name, urlImg: dataSource[indexPath.row].urlImg)
        cell?.addRoundCorners(cornerRadius: 15)
        return cell ?? UICollectionViewCell()
    }
}
extension HomeScreenViewController: HomeHeaderDelegate {
    
    func begingSearch() {
        if statusSearch == .INACTIVE {
            searchingData = dataSource
        }
        UIView.animate(withDuration: 0.15, animations: {[ weak self] in

            self?.headerAnimator?.scrolllViewBeging()
            self?.view.layoutIfNeeded()
        }) { (finish)  in
           // self.tableView.isHidden = true
        }
    }
    
    func search(_ query: String?) {
        guard let query = query, statusSearch != .SEARCHING else { return }
        self.searchingFlag = true
        statusSearch = .SEARCHING
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline:  .now() + 0.1) { [weak self] in
            self?.statusSearch = .SEARCHED
            guard let searching = self?.searchingFlag, searching else {return}
            self?.searchingFlag = false
            let dish = self?.searchingData.filter{$0.name?.range(of: query, options: .caseInsensitive) != nil}
            if let data = dish, !data.isEmpty {
                self?.statusSearch = .SUCCESS_SEARCH
                self?.dataSource = data
            } else {
                self?.statusSearch = .EMPTY_SEARCH
                self?.dataSource = []
            }
            self?.reloadDataCompletion { [weak self] in
                self?.reloadCallback?()
            }
        }
        self.collectionView.isHidden = true
        self.loading.startAnimating()
        self.loading.isHidden = false
        self.resultSearchLbl.text = "Buscando..."
    }
    
    
    func searchFast(_ query: String?) {
        guard  statusSearch != .SEARCHING else { return }
        self.searchingFlag = true
        statusSearch = .SEARCHING
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.searchingFlag = false
            self?.statusSearch = .SEARCHED
            let dishResult1 = self?.searchingDataSet.filter{ $0.name == query }
            self?.dataSource = []
            if let data = dishResult1 {
                self?.dataSource = Array(data)
            } else {
                self?.dataSource = []
            }
            self?.reloadDataCompletion { [weak self] in
                self?.reloadCallback?()
            }
        }
    }
    
    func didCancelSearch() {
        
            dataSource = searchingData
        
        statusSearch = .INACTIVE
        headerAnimator?.scrolllViewComplete()
       
        reloadDataCompletion { [weak self] in
            if let dataSsource = self?.dataSource, dataSsource.isEmpty {
                self?.collectionView.isHidden = true
            } else {
                self?.collectionView.isHidden = false
            }
        }
    }
    
    func activateSearching() {
        dataSource =  searchingData
        collectionView.isHidden = true
        loading.isHidden = true
        resultSearchLbl.text = "Search"
    }
}



enum searchStatus {
    case SEARCHING
    case SEARCHED
    case INACTIVE
    case SUCCESS_SEARCH
    case EMPTY_SEARCH
}
