//
//  ViewController.swift
//  iOS-HomeWork3
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLocationPoints()
        checkLocationServices()
    }
    
    
    
    func loadLocationPoints() {
        
        // first point
        let firstPoint = MKPointAnnotation()
        firstPoint.coordinate = CLLocationCoordinate2D(latitude: 56.9827027, longitude: 24.20365334)
        firstPoint.title = "Adidas veikals"
        firstPoint.subtitle = "Oficiālais Adidas dīleris Latvijā"
        mapView.addAnnotation(firstPoint)
        
        // second point
        let secondPoint = MKPointAnnotation()
        secondPoint.coordinate = CLLocationCoordinate2D(latitude: 57.519642, longitude: 25.340090)
        secondPoint.title = "Nike veikals"
        secondPoint.subtitle = "Oficiālais Nike dīleris Latvijā"
        mapView.addAnnotation(secondPoint)
        
        // third point
        let thirdPoint = MKPointAnnotation()
        thirdPoint.coordinate = CLLocationCoordinate2D(latitude: 55.86885089, longitude: 26.51534736)
        thirdPoint.title = "Lada veikals"
        thirdPoint.subtitle = "Oficiālais Lada dīleris Latvijā"
        mapView.addAnnotation(thirdPoint)
    }
    
    func setupLocationManager() {
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case . restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    func drawRoute(to: CLLocationCoordinate2D) {
        let source = MKPlacemark(coordinate: mapView.userLocation.coordinate)
        let destination = MKPlacemark(coordinate: to)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: source)
        directionRequest.destination = MKMapItem(placemark: destination)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { response, error in
            if let response = response, let route = response.routes.first {
                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .init(red: 108/255.0, green: 23/255.0, blue: 220/255.0, alpha: 1.0)
        renderer.lineWidth = 3
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let coordinate = view.annotation?.coordinate {
            drawRoute(to: coordinate)
        }
    }
}
