//
//  OfferAnnotationView.swift
//  GPless
//
//  Created by Khaled Bohout on 11/2/20.
//

import UIKit

class OfferAnnotationView: UIView {
    
    var offers = [OfferModel]()
    

    @IBOutlet weak var offersCollectionView: UICollectionView!

     func initCollectionView(offers: [OfferModel]) {
        
        let nib = UINib(nibName: "OffersCollectionViewCell", bundle: nil)
        
        offersCollectionView.register(nib, forCellWithReuseIdentifier: "OffersCollectionViewCell")
        
        offersCollectionView.dataSource = self
        
        offersCollectionView.delegate = self
        
        self.offers = offers
    }
}

extension OfferAnnotationView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCollectionViewCell", for: indexPath) as? OffersCollectionViewCell else {
            
            fatalError("can't dequeue CustomCell")
        }
        
        cell.configureCell(offer: offers[indexPath.row])
        
        return cell
    }
    
    
}
