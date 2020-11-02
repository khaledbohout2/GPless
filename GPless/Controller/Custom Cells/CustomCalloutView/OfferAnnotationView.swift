//
//  OfferAnnotationView.swift
//  GPless
//
//  Created by Khaled Bohout on 11/2/20.
//

import UIKit

class OfferAnnotationView: UIView {
    

    @IBOutlet weak var offersCollectionView: UICollectionView!

     func initCollectionView() {
        
        let nib = UINib(nibName: "OffersCollectionViewCell", bundle: nil)
        offersCollectionView.register(nib, forCellWithReuseIdentifier: "OffersCollectionViewCell")
        offersCollectionView.dataSource = self
    }
}

extension OfferAnnotationView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCollectionViewCell", for: indexPath) as? OffersCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
        }
      //  cell.label.text = "\(indexPath.item)"
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 205, height: 184)
//    }
    
    
}
