//
//  OfferAnnotationView.swift
//  GPless
//
//  Created by Khaled Bohout on 11/2/20.
//

import UIKit

class OfferAnnotationView: UIView {
    
    var offers = NearestOffer()
    

    @IBOutlet weak var offersCollectionView: UICollectionView!

     func initCollectionView(offers: NearestOffer) {
        
        let nib = UINib(nibName: "OffersCollectionViewCell", bundle: nil)
        
        offersCollectionView.register(nib, forCellWithReuseIdentifier: "OffersCollectionViewCell")
        
        offersCollectionView.dataSource = self
        
        offersCollectionView.delegate = self
        
        self.offers = offers
        
        offersCollectionView.reloadData()
    }
}

extension OfferAnnotationView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(offers.offers!.count)
        return offers.offers!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCollectionViewCell", for: indexPath) as! OffersCollectionViewCell
        
        cell.configureCell(offer: offers.offers![indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 205, height: 194)
    }
    
    
}
