//
//  MapViewController.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 18/04/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController, Storyboarded, ViewProtocol {
    
    var presenter: MapPresenterProtocol?
    private var dataSource: LocationOriginDto?
    
    @IBOutlet weak var containerMap: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerMap.backgroundColor = .red
        dataSource = presenter?.dataLocation
        setupPoints()
    }

    // MARK: - Map

    lazy var map: MKMapView = {
        var map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
      return map
    }()
    
    private func setupPoints() {
        containerMap.addSubview(map)
        NSLayoutConstraint.activate([
            map.leadingAnchor.constraint(equalTo: containerMap.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: containerMap.trailingAnchor),
            map.topAnchor.constraint(equalTo: containerMap.topAnchor),
            map.bottomAnchor.constraint(equalTo: containerMap.bottomAnchor)
        ])
        map.delegate = self
        guard let dataLocation = dataSource  else { return  }
        var marker: CustomMKPointAnnotationProtocol = CustomAnnotation()

        marker.coordinate = CLLocationCoordinate2D(latitude: dataLocation.latitudePoint, longitude: dataLocation.longitudePoint )
        
        marker.title = dataLocation.name
        marker.subtitle = dataLocation.description ?? ""
        marker.additionalInfo = dataLocation.description
        marker.urlImg = dataLocation.urlImg
        map.addAnnotation(marker)
        
        guard let heading = CLLocationDirection(exactly: 12) else { return  }
        map.camera = MKMapCamera(lookingAtCenter: marker.coordinate, fromDistance: 80000, pitch: .zero, heading: heading)
    }
}
extension MapViewController: MapViewProtocol {}
extension MapViewController: MKMapViewDelegate {

    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let anotaation = view.annotation as? CustomAnnotation {
            presenter?.showInformation(title: anotaation.title, description: anotaation.additionalInfo, urlImg: anotaation.urlImg)
        }
    }
}

