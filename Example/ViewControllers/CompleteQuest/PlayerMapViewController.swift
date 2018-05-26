//
//  PlayerMapViewController.swift
//  Example
//
//  Created by Pabel Nunez Landestoy on 5/26/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import UIKit
import MapKit

class PlayerMapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    fileprivate let locationManager = CLLocationManager()
    fileprivate var startedLoadingPOIs = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.showsCompass = true

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        }else{
            print("Location services are disabled, please enable before trying again.")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            let location = locations.last!
            print("Accuracy: \(location.horizontalAccuracy)")
            
            if location.horizontalAccuracy < 100 {
                
                manager.stopUpdatingLocation()
                let span = MKCoordinateSpan(latitudeDelta: 0.014, longitudeDelta: 0.014)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.region = region
                
            }else{
                print("Location accuracy is not under 100 meters, skipping...")
            }
        }else{
            print("Failed to get current location")
        }
    }
    
    
}
// MARK: - Extensions
extension ViewController: CLLocationManagerDelegate {
    
}
