//
//  HomeHeaderView.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 15/04/24.
//

import Foundation
import UIKit

protocol HomeHeaderDelegate {
    func search(_ query: String?)
    func didCancelSearch()
    func begingSearch()
    func searchFast(_ query: String?)
}


class HomeHeaderView: UIView {
    
       @IBOutlet var headerImg: UIImageView!
       @IBOutlet var title: UILabel!
       @IBOutlet var searchView: UIView!
       @IBOutlet var contentView: UIView!
       private var blackOverlayView: UIView?
       
       var viewC: HomeHeaderDelegate?
       private var searchController = UISearchController(searchResultsController: nil)

    
     override init(frame: CGRect) {
         super.init(frame: frame)
         commonInit()
         setupUI()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         commonInit()
         setupUI()
     }
       
       func commonInit()  {
           Bundle.main.loadNibNamed("HomeHeaderView", owner: self)
           addSubview(contentView)
           contentView.frame = bounds
           contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       }
     
     func setupUI() {
         backgroundColor = UIColor.green
         self.title.text = ""
         setupSearchController()
         setupKeyboardObservers()
     }
    func actualizarComponentes() {
        guard let viewOverlay = blackOverlayView else { return }
        blackOverlayView?.removeFromSuperview()
        blackOverlayView = UIView(frame: bounds)
        blackOverlayView?.backgroundColor = UIColor.black.withAlphaComponent(0.8)

        contentView.addSubview(blackOverlayView!)
        self.layoutIfNeeded()
    }
    func deselected() {
        //searchController.searchBar.resignFirstResponder()
        searchController.isActive = false
        blackOverlayView?.removeFromSuperview()
        blackOverlayView = nil
        //viewC?.didCancelSearch()
    }
    
    func getSearchText() -> String? {
        if  let searchText = searchController.searchBar.text {
            return searchText
        }
        return nil
    }
    func setSearch(lastSearch: String?) {
        
        searchController.searchBar.text = lastSearch ?? "Sin busqueda"
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardHeight = keyboardFrame.size.height
    
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
     
    
}
// MARK: - Search Controller
extension HomeHeaderView {
    func setupSearchController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Intentemos cocinar"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.searchBar.barStyle = .default
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.frame = searchView.bounds
        searchView.addSubview(searchController.searchBar)
        searchController.searchBar.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]

        searchController.searchBar.barTintColor = UIColor(named: "base_color")
        searchController.searchBar.alpha = 1.0
        searchController.searchBar.textField?.backgroundColor = .white
        searchController.searchBar.addRoundCorners(cornerRadius: 20)
        self.layoutIfNeeded()
        
       // definesPresentationContext = true
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.accessibilityIdentifier = "SearchCocina"
        }

    }

}

// MARK: - Search Controller
extension HomeHeaderView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Se toco search")
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        //searchController.isActive = false
        viewC?.searchFast(searchText)

    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        blackOverlayView?.removeFromSuperview()
        blackOverlayView = nil
        viewC?.didCancelSearch()
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        blackOverlayView = UIView(frame: bounds)
        var colorBgd = UIColor.black.withAlphaComponent(0.5)
        blackOverlayView?.backgroundColor = colorBgd
        contentView.addSubview(blackOverlayView!)
        viewC?.begingSearch()
        return true

    }
}

extension HomeHeaderView : UISearchControllerDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewC?.search(searchText)
    }
}

extension UISearchBar {
    var textField: UITextField? {
        guard let text = self.value(forKey: "searchField") as? UITextField else {
            return nil
        }

        return text
    }
}
