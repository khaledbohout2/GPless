//
//  SetLocationVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import UIKit
import MapKit
import CoreLocation

class SetLocationVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var mapKit: MKMapView!
    
    var keyBoardHeight: CGFloat?
    var height: CGFloat?
    let locationManager = CLLocationManager()
    var currentLocation: Location?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocation()
        
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        searchBar.isOpaque = false
      //  searchBar.searchBarStyle = .minimal
      //  searchBar.barTintColor = UIColor.clear
      //  searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: UIBarMetrics.default)
        searchBar.isTranslucent = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    func initLocation() {
        
        manager = CLLocationManager() //instantiate
        manager.delegate = self // set the delegate
        manager.desiredAccuracy = kCLLocationAccuracyBest // required accurancy

        manager.requestWhenInUseAuthorization() // request authorization
        manager.startUpdatingLocation() //update location

        var lat = manager.location.coordinate.latitude // get lat
        var long = manager.location.coordinate.longitude // get long
        var coordinate = CLLocationCoordinate2DMake(lat, long)// set coordinate

        var latDelta:CLLocationDegrees = 0.01 // set delta
        var longDelta:CLLocationDegrees = 0.01 // set long
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)

        self.mapView.setRegion(region, animated: true)
        centerAnnotation.coordinate = mapView.centerCoordinate
        self.mapView.addAnnotation(centerAnnotation)
    }
    

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
                self.height = keyboardSize.height
                self.searchBtn.frame.origin.y -= height!
            
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {

        if self.height != nil {
            
            self.searchBtn.frame.origin.y += self.height!
        }
        
        
    }
    
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }


}

extension SetLocationVC : CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
                if let location = locations.first {
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
                    let region = MKCoordinateRegion(center: location.coordinate, span: span)
                    mapKit.setRegion(region, animated: true)
                    
                    let lat = "\(location.coordinate.latitude)"
                    let long = "\(location.coordinate.longitude)"
                    self.currentLocation = Location(longitude: long, latitude: lat)
                    
                    let pin = MKPointAnnotation()
                   // pin.title = "London"
                    pin.coordinate = mapKit.centerCoordinate
                    
                    mapKit.addAnnotation(pin)

            }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "marker"
        var view: MKAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            dequeuedView.image = UIImage(named: "locatin logo icon-2")
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.isDraggable = true
            view.canShowCallout = false
        }
        return view
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }

}
