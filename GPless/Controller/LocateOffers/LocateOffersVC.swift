//
//  LocateOffersVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/9/20.
//

import UIKit
import MapKit

class LocateOffersVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var footerView: UIView!
    
    var searchCategories = [SearchCategory]()
    var offers = [OfferPlace]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Locate Offer"
        
        makeTopCornerRadius(myView: footerView)
        mapView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        setAnnotation()

        // Do any additional setup after loading the view.
    }
    
    func setAnnotation() {

        let offer1 = OfferPlace(lat: 30.0444 , long: 31.2357, title: "Cairo")
        offers.append(offer1)

        for offer in offers {
            
            let annotation = MKPointAnnotation()
            annotation.title = offer.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: offer.lat, longitude: offer.long)
            mapView.addAnnotation(annotation)
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func showOffersBtnTapped(_ sender: Any) {
        
        let storyBaord = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyBaord.instantiateViewController(withIdentifier: "SearchResultsVC") as! SearchResultsVC
        self.navigationController?.pushViewController(vc, animated: true)
      //  self.present(vc!, animated: true, completion: nil)
        
    }
    
}

extension LocateOffersVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
            annotationView?.image = UIImage(named: "")
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "searchIcon")
        return annotationView
    }
    
}
