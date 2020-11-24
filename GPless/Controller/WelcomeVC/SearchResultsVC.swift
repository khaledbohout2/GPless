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
    var offers = [NearestOffer]()
    
    var currentLocation : Location!
    
    
    private var allAnnotations = [MKAnnotation]()
    
    private var displayedAnnotations: [MKAnnotation]? {
        willSet {
            if let currentAnnotations = displayedAnnotations {
                mapView.removeAnnotations(currentAnnotations)
            }
        }
        didSet {
            if let newAnnotations = displayedAnnotations {
                mapView.addAnnotations(newAnnotations)
            }
          //  centerMapOnSanFrancisco()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTopCornerRadius(myView: footerView)
        mapView.delegate = self
        searchCategoriesCollectionView.register(UINib(nibName: "SearchCategoryCVCell", bundle: nil), forCellWithReuseIdentifier: "SearchCategoryCVCell")
        searchCategoriesCollectionView.delegate = self
        searchCategoriesCollectionView.dataSource = self
        getDummyData()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(_:)))
        footerView.addGestureRecognizer(gesture)

        initLocation()
        

    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func registerMapAnnotationViews() {

        mapView.register(OfferAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(CustomAnnotation.self))

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
    
    
    func initLocation() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        
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

        
        for offer in offers {
            
            let lat = Double(offer.location?.latitude ?? "30.025363799999997")!
            let long = Double(offer.location?.longitude ?? "31.481323999999994")!
            let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let annotation = CustomAnnotation(coordinate: coordinates, offers: offer)
            allAnnotations.append(annotation)

        }
        
        print(allAnnotations.count)
        
        displayedAnnotations = allAnnotations
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
    
    /// Called whent he user taps the disclosure button in the bridge callout.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        

    }
    
    /// The map view asks `mapView(_:viewFor:)` for an appropiate annotation view for a specific annotation.
    /// - Tag: CreateAnnotationViews
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
            return nil
        }
        
        var annotationView: MKAnnotationView?
        
        if let annotation = annotation as? CustomAnnotation {
            annotationView = setupCustomAnnotationView(for: annotation, on: mapView)
        }
        
        return annotationView
    }
    

    
    /// Create an annotation view for the Ferry Building, and add an image to the callout.
    /// - Tag: CalloutImage
    private func setupCustomAnnotationView(for annotation: CustomAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        
                var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
                if annotationView == nil{
                    annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
                    annotationView?.canShowCallout = false
                } else {
        
                    annotationView?.annotation = annotation
                }
        
                annotationView?.image = UIImage(named: "locatin logo icon-2")
    
        
        return annotationView!
        
        
        
    }
    
    
    
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            // 1
            if view.annotation is MKUserLocation
            {
                // Don't proceed with custom callout
                return
            }

            let views = Bundle.main.loadNibNamed("OfferAnnotationView", owner: nil, options: nil)
            let calloutView = views?[0] as! OfferAnnotationView
            let annotation = view.annotation as! CustomAnnotation
            let offer = annotation.offers!
            calloutView.initCollectionView(offers: offer)
            makeCornerRadius(myView: calloutView)

            calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
            view.addSubview(calloutView)
            mapView.setCenter((view.annotation?.coordinate)!, animated: true)
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
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
                    let region = MKCoordinateRegion(center: location.coordinate, span: span)
                    mapView.setRegion(region, animated: true)
                    
                    let lat = "\(location.coordinate.latitude)"
                    let long = "\(location.coordinate.longitude)"
                    self.currentLocation = Location(longitude: long, latitude: lat)
                    getNearestOffers()

            }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }

}

//MARK: - APIs

extension SearchResultsVC {
    
    func getNearestOffers() {
        
        
        _ = Network.request(req: NearestOfferRequest(location: self.currentLocation)) { (result) in
            
            switch result {
            case .success(let nearestOffers):
                print(nearestOffers)
                self.offers = nearestOffers
                self.setAnnotation()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        }
    }
}


