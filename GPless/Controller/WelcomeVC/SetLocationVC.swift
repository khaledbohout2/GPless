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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
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
                    let span = MKCoordinateSpan(latitudeDelta: 30.0444, longitudeDelta: 31.2357)
                    let region = MKCoordinateRegion(center: location.coordinate, span: span)
                    mapKit.setRegion(region, animated: true)
            }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }

}
