//
//  GoogleMapsViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 30.05.2023.
//

import UIKit
import GoogleMaps
import UIKit
import GoogleMaps
import UIKit
import GoogleMaps

class GoogleMapsViewController: UIViewController {

    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var pointInfoView: UIView!

    var locationManager: CLLocationManager!
    var pointInfo: StoreInfoView?
    var googleMapView: GMSMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()

        if CLLocationManager.locationServicesEnabled() {
            DispatchQueue.main.async {
                self.locationManager = CLLocationManager()
                self.locationManager.delegate = self
                self.locationManager.requestWhenInUseAuthorization()
            }
        }

        pointInfo?.roundCorners([.topLeft, .topRight], radius: 30)
    }

    func prepareUI() {
        pointInfoView.isHidden = true
        pointInfo = StoreInfoView.setup(in: pointInfoView)
    }
}

extension GoogleMapsViewController: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus = manager.authorizationStatus

        if authorizationStatus == .authorizedWhenInUse {
            DispatchQueue.main.async {
                let camera = GMSCameraPosition.camera(withLatitude: 50.450526, longitude: 30.52797, zoom: 15.0)
                self.googleMapView = GMSMapView.map(withFrame: self.mapView.bounds, camera: camera)
                self.googleMapView?.delegate = self

                if let mapView = self.googleMapView {
                    self.mapView.addSubview(mapView)

                    GoogleMapManager().getStoreLocations { locations in
                        if let locations = locations {
                            self.addMarkersToMap(with: locations, on: mapView)
                        }
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                return
            }
        }
    }

    func addMarkersToMap(with locations: [Location], on mapView: GMSMapView) {
        for location in locations {
            let marker = GMSMarker()

            marker.position = CLLocationCoordinate2D(latitude: Double(location.latitude), longitude: Double(location.longitude))
            marker.title = location.title
            marker.snippet = location.snippet
            marker.map = mapView
            marker.userData = location

            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
            marker.tracksInfoWindowChanges = true
        }
    }
}

extension GoogleMapsViewController: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let location = marker.userData as? Location else { return false }
        pointInfo?.configure(with: location)
        pointInfoView.isHidden = false
        return false
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        pointInfoView.isHidden = true
    }
}
