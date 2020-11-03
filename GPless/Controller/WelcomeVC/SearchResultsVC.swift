//
//  SearchResultsVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import UIKit
import MapKit

class SearchResultsVC: UIViewController {
    
    
    @IBOutlet weak var searchCategoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var footerView: UIView!
    
    
    var searchCategories = [SearchCategory]()
    var offers = [OfferPlace]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTopCornerRadius(myView: footerView)
        
        mapView.delegate = self
        
        searchCategoriesCollectionView.register(UINib(nibName: "SearchCategoryCVCell", bundle: nil), forCellWithReuseIdentifier: "SearchCategoryCVCell")
        searchCategoriesCollectionView.delegate = self
        searchCategoriesCollectionView.dataSource = self
        getDummyData()
        setAnnotation()

        // Do any additional setup after loading the view.
    }
    
    func getDummyData() {
        
        let first = SearchCategory(text: "Food", color: "#F6C677")
        searchCategories.append(first)
        let second = SearchCategory(text: "Electronic", color: "##282828")
        searchCategories.append(second)
        let third = SearchCategory(text: "Fashion", color: "##E95FA4")
        searchCategories.append(third)
        let forth = SearchCategory(text: "data", color: "#F6C677")
        searchCategories.append(forth)
    }
    
    func setAnnotation() {

        
        let offer1 = OfferPlace(lat: 30.0444 , long: 31.2357, title: "Cairo")
        offers.append(offer1)
        let offer2 = OfferPlace(lat: 31.2001 , long: 29.9187, title: "Alex")
        offers.append(offer2)
        let offer3 = OfferPlace(lat: 31.0409 , long: 31.3785, title: "Mansoura")
        offers.append(offer3)
        let offer4 = OfferPlace(lat: 24.0889 , long: 32.8998, title: "Aswan")
        offers.append(offer4)

        
        for offer in offers {
            
            let annotation = MKPointAnnotation()
            annotation.title = offer.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: offer.lat, longitude: offer.long)
            mapView.addAnnotation(annotation)
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func showOffersBtnTapped(_ sender: Any) {
        
        let storibaord = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = storibaord.instantiateViewController(identifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(homeVC, animated: true)
        
    }
    
}



extension SearchResultsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return searchCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCategoryCVCell", for: indexPath) as! SearchCategoryCVCell
        
        cell.congigureCell(category: searchCategories[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 107, height: 40)
    }
}

extension SearchResultsVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "searchIcon")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        // 2
      //  let starbucksAnnotation = view.annotation as! StarbucksAnnotation
        let views = Bundle.main.loadNibNamed("OfferAnnotationView", owner: nil, options: nil)
        let calloutView = views?[0] as! OfferAnnotationView
        calloutView.initCollectionView()
        makeTopCornerRadius(myView: calloutView)
//        calloutView.starbucksName.text = starbucksAnnotation.name
//        calloutView.starbucksAddress.text = starbucksAnnotation.address
//        calloutView.starbucksPhone.text = starbucksAnnotation.phone
//        calloutView.starbucksImage.image = starbucksAnnotation.image
//        let button = UIButton(frame: calloutView.starbucksPhone.frame)
//        button.addTarget(self, action: #selector(ViewController.callPhoneNumber(sender:)), for: .touchUpInside)
//        calloutView.addSubview(button)
        // 3
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
     //   mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
    
}
