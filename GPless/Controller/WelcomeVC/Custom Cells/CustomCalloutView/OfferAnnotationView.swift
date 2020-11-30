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

    @IBOutlet weak var btnUPCollection: UIButton!
    
    @IBOutlet weak var btnBackCollectionView: UIButton!
    
    func initCollectionView(offers: NearestOffer) {
        
        let nib = UINib(nibName: "OffersCollectionViewCell", bundle: nil)
        
        offersCollectionView.register(nib, forCellWithReuseIdentifier: "OffersCollectionViewCell")
        
        offersCollectionView.dataSource = self
        
        offersCollectionView.delegate = self
        
        self.offers = offers
        
        if offers.offers!.count < 2  {
            
            self.btnUPCollection.isHidden = true
            self.btnBackCollectionView.isHidden = true
        }
        
        offersCollectionView.reloadData()
    }
    
    @IBAction func btnUpTapped(_ sender: Any) {
       // self.offersCollectionView.
        let visibleItems: NSArray = self.offersCollectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
// This part here
        if nextItem.row < offers.offers!.count {
            self.offersCollectionView.scrollToItem(at: nextItem, at: .left, animated: true)
        }
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        
        // self.offersCollectionView.
         let visibleItems: NSArray = self.offersCollectionView.indexPathsForVisibleItems as NSArray
         let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
         let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
 // This part here
         if nextItem.row > 0 {
             self.offersCollectionView.scrollToItem(at: nextItem, at: .right, animated: true)
         }
        
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
        return CGSize(width: 195, height: 194)
    }
    
//    func scrollToNextItem() {
//        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
//        self.moveToFrame(contentOffset: contentOffset)
//    }
//
//    func scrollToPreviousItem() {
//        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
//        self.moveToFrame(contentOffset: contentOffset)
//    }
    
    
}
