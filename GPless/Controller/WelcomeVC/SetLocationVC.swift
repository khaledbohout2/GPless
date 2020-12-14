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
    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var locateOfferBtn: UIButton!
    
    var keyBoardHeight: CGFloat?
    var height: CGFloat?
    let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocation()
        localize()
        makeTopCornerRadius(myView: footerView)
        
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        searchBar.isOpaque = false
        searchBar.isTranslucent = false
        

        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 36)
        imageView.image = UIImage(named: "locatin logo icon-2")
        imageView.center = mapKit.center
        self.view.addSubview(imageView)

        // Do any additional setup after loading the view.
    }
    
    func initLocation() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        mapKit.delegate = self
    }
    
    func localize() {
        locateOfferBtn.setTitle("locateOffer", for: .normal)
    }
    
    func setAddress(location: CLLocation) {

        let ceo: CLGeocoder = CLGeocoder()
        ceo.reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                
                let pm = placemarks
                
                if placemarks != nil {

                if pm!.count > 0 {
                    let pm = placemarks![0]

                    var addressString : String = ""

                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality!
                    }

                    self.addressLbl.text = addressString
                }
              }
        })

        
    }
    
    
    @IBAction func locationBtnTaaped(_ sender: Any) {
        
       // currentLocation
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchResultsVC =  storyboard.instantiateViewController(identifier: "SearchResultsVC") as! SearchResultsVC
        searchResultsVC.currentLocation = Location(longitude: "\(mapKit.centerCoordinate.longitude)", latitude: "\(mapKit.centerCoordinate.latitude)")
        self.navigationController?.pushViewController(searchResultsVC, animated: true)
    }
    
    
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }
}

extension SetLocationVC : CLLocationManagerDelegate, MKMapViewDelegate {

    
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
            }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        
        let lat  = mapView.centerCoordinate.latitude
        let long = mapView.centerCoordinate.longitude
        let location = CLLocation(latitude: lat, longitude: long)
        
        setAddress(location: location)
    }

}
