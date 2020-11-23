//
//  SearchResultsVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import UIKit
import MapKit

class SearchResultsVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var footerView: UIView!
    
    var viewCenter: CGPoint!
    
    var resultSearchController:UISearchController? = nil
    let locationManager = CLLocationManager()
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
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(_:)))
        footerView.addGestureRecognizer(gesture)
   //     gesture.delegate = self

        initLocation()
        
       // footerView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragView)))
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func wasDragged(_ gestureRecognizer: UIPanGestureRecognizer) {

        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {

            let translation = gestureRecognizer.translation(in: self.view)
            print(gestureRecognizer.view!.center.y)

            if(gestureRecognizer.view!.center.y < 855) {

                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)

            } else {
                gestureRecognizer.view!.center = CGPoint(x:gestureRecognizer.view!.center.x, y:854)
            }
            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
    }
    
//    @objc func dragView(gesture: UIPanGestureRecognizer) {
//        let target = gesture.view!
//
//        switch gesture.state {
//        case .began, .ended:
//            viewCenter = target.center
//        case .changed:
//            let translation = gesture.translation(in: self.view)
//            target.center = CGPoint(x: viewCenter!.x + translation.x, y: viewCenter!.y + translation.y)
//        default: break
//        }
//    }
    
    func initLocation() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
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
        
        let storyBaord = UIStoryboard(name: "Home", bundle: nil)
        
        let vc = storyBaord.instantiateViewController(withIdentifier: "HomeTBC") 
        vc.modalPresentationStyle =  .fullScreen
        self.present(vc, animated: true, completion: nil)
        
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

extension SearchResultsVC : CLLocationManagerDelegate {

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                if let location = locations.first {
                    let span = MKCoordinateSpan(latitudeDelta: 30.0444, longitudeDelta: 31.2357)
                    let region = MKCoordinateRegion(center: location.coordinate, span: span)
                    mapView.setRegion(region, animated: true)
            }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }

}


