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
    
    
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var offersNumberLbl: UILabel!
    
    var viewCenter: CGPoint!
    var resultSearchController:UISearchController? = nil
    let locationManager = CLLocationManager()
    var searchCategories = [CategoryElement]()
    var offers = [NearestOffer]()
    var categoryIndex = 1
    var currentLocation : Location!
    var selectedCategory: String?
    
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
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(_:)))
        footerView.addGestureRecognizer(gesture)

        initCollectionView()
        initLocation()
        setUpUI()
        getCategories()
        
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUpUI() {
        
        makeTopCornerRadius(myView: footerView)
        mapView.delegate = self

        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func initCollectionView() {
        
        searchCategoriesCollectionView.register(UINib(nibName: "SearchCategoryCVCell", bundle: nil), forCellWithReuseIdentifier: "SearchCategoryCVCell")
        searchCategoriesCollectionView.delegate = self
        searchCategoriesCollectionView.dataSource = self
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! SearchCategoryCVCell
        
        let cells = searchCategoriesCollectionView.visibleCells as! [SearchCategoryCVCell]
        
        let opacity:CGFloat = 0.25
        
        for cell in cells {
            cell.categoryView.backgroundColor = hexStringToUIColor(hex: "#C5C1C1").withAlphaComponent(opacity)
        }
        
        cell.categoryView.backgroundColor = hexStringToUIColor(hex: "#F6C677")
        
        self.selectedCategory = searchCategories[indexPath.row].categoryName
        self.allAnnotations.removeAll()
        getCategoryOffers(category: selectedCategory!)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 107, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == self.searchCategories.count - 1 {
            categoryIndex += 1
            getCategories()
            
        }
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
        
        
      //  annotationView?.image = annotation.offers?.vendor.
    
        
        return annotationView!
        
    }
    
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            // 1
            if view.annotation is MKUserLocation
            {
                // Don't proceed with custom callout
                return
                
            } else {
                
                let annotation = view.annotation as! CustomAnnotation
                if annotation.offers?.offers?.count == 0 {
                    return
                }
                
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
                    

                    let coordinates = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    let annotation = CustomAnnotation(coordinate: coordinates, offers: NearestOffer())
                    allAnnotations.append(annotation)

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
                    
                    getNearestOffers()

            }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
//    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
//            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
//            let lat: Double = Double("\(pdblLatitude)")!
//            //21.228124
//            let lon: Double = Double("\(pdblLongitude)")!
//            //72.833770
//            let ceo: CLGeocoder = CLGeocoder()
//            center.latitude = lat
//            center.longitude = lon
//
//            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
//
//
//            ceo.reverseGeocodeLocation(loc, completionHandler:
//                {(placemarks, error) in
//                    if (error != nil)
//                    {
//                        print("reverse geodcode fail: \(error!.localizedDescription)")
//                    }
//                    let pm = placemarks! as [CLPlacemark]
//
//                    if pm.count > 0 {
//                        let pm = placemarks![0]
////                        print(pm.country)
////                        print(pm.locality)
////                        print(pm.subLocality)
////                        print(pm.thoroughfare)
////                        print(pm.postalCode)
////                        print(pm.subThoroughfare)
//                        var addressString : String = ""
////                        if pm.subLocality != nil {
////                          //  addressString = addressString + pm.subLocality! + ", "
////                        }
//                        if pm.thoroughfare != nil {
//                            addressString = addressString + pm.thoroughfare! + ", "
//                        }
//                        if pm.locality != nil {
//                            addressString = addressString + pm.locality!
//                        }
////                        if pm.country != nil {
////                            addressString = addressString + pm.country! + ", "
////                        }
////                        if pm.postalCode != nil {
////                            addressString = addressString + pm.postalCode! + " "
////                        }
//
//
//                        print(addressString)
//                        self.addressLbl.text = addressString
//                  }
//            })
//
//        }

}

//MARK: - APIs

extension SearchResultsVC {
    
    func getNearestOffers() {
        
        
        _ = Network.request(req: NearestOfferRequest(location: self.currentLocation)) { (result) in
            
            switch result {
            case .success(let nearestOffers):
                print(nearestOffers)
                self.offers = nearestOffers
                if nearestOffers.count > 0 {
                self.offersNumberLbl.text = "You have \(nearestOffers.count) offers Nearby from you"
                    
                } else {
                    
                    self.offersNumberLbl.text = "You have 0 offers Nearby from you"
                }
                self.setAnnotation()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        }
    }
    
    func getCategories() {
        
        _ = Network.request(req: CategoriesRequest(index: "\(categoryIndex)"), completionHandler: { (result) in
           switch result {
           case .success(let response):
           print(response)
            if self.categoryIndex == 1 {
            self.searchCategories = response.categories!
                
            } else {
                
                for cat in response.categories! {
                    self.searchCategories.append(cat)
                }
            }
            self.searchCategoriesCollectionView.reloadData()
           case .cancel(let cancelError):
           print(cancelError!)
           case .failure(let error):
           print(error!)
            }
        })
    }
    
    func getCategoryOffers(category: String) {
        
        _ = Network.request(req: CategoryNearestOffers(location: self.currentLocation, categoryType: category), completionHandler: { (result) in
            switch result {
            case .success(let nearestOffers):
                print(nearestOffers)
                self.offers = nearestOffers
                self.offersNumberLbl.text = "\(nearestOffers.count)"
                self.setAnnotation()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
        
    }
}


