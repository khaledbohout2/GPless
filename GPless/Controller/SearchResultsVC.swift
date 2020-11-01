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
    
    var searchCategories = [SearchCategory]()
    var offers = [Offer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        
        let offer1 = Offer(lat: 30.0444 , long: 31.2357, title: "Cairo")
        offers.append(offer1)
        let offer2 = Offer(lat: 31.2001 , long: 29.9187, title: "Alex")
        offers.append(offer2)
        let offer3 = Offer(lat: 31.0409 , long: 31.3785, title: "Mansoura")
        offers.append(offer3)
        let offer4 = Offer(lat: 24.0889 , long: 32.8998, title: "Aswan")
        offers.append(offer4)

        
        for offer in offers {
            
            let annotation = MKPointAnnotation()
            annotation.title = offer.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: offer.lat, longitude: offer.long)
            mapView.addAnnotation(annotation)
        }

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
        
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
           // annotationView!.image =  UIImage(named: "")
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
}
