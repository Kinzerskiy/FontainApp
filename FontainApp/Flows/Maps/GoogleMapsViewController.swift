//
//  GoogleMapsViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 30.05.2023.
//

import UIKit
import GoogleMaps

class GoogleMapsViewController: UIViewController {
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var pointInfoView: UIView!
    
    var locationManager: CLLocationManager!
    var pointInfo: StoreInfoView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
        
        pointInfo?.roundCorners([.topLeft, .topRight], radius: 30)
    }
    
    func prepareUI() {
        pointInfo = StoreInfoView.setup(in: pointInfoView)
    }
}

extension GoogleMapsViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus = manager.authorizationStatus
        
        if authorizationStatus == .authorizedWhenInUse {
            DispatchQueue.main.async {
                let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
                let googleMapView = GMSMapView.map(withFrame: self.mapView.bounds, camera: camera)
                
                self.mapView.addSubview(googleMapView)
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
                marker.title = "Sydney"
                marker.snippet = "Australia"
                marker.map = googleMapView
            }
        } else {
            DispatchQueue.main.async {
                return
            }
        }
    }
}
