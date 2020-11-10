//
//  PaidOffersListVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class PaidOffersListVC: UIViewController {
    
    
    @IBOutlet weak var paidOffersCollectionView: UICollectionView!
    
    var gridView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()

    }
    
    func initCollectionView() {
        
        let paidOffersNib = UINib(nibName: "PaidOffersCollectionViewCell", bundle: nil)
        let paidOffersVerticalNib = UINib(nibName: "PaidOffersVerticalCollectionViewCell", bundle: nil)
        paidOffersCollectionView.register(paidOffersNib, forCellWithReuseIdentifier: "PaidOffersCollectionViewCell")
        paidOffersCollectionView.register(paidOffersVerticalNib, forCellWithReuseIdentifier: "PaidOffersVerticalCollectionViewCell")
        paidOffersCollectionView.delegate = self
        paidOffersCollectionView.dataSource = self

    }
    
    
    @IBAction func switchListingBtnTapped(_ sender: Any) {
        
        if gridView {
            
            if let flowLayout = paidOffersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .vertical
            }
            gridView = !gridView
            
        } else {
            
            if let flowLayout = paidOffersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
            }
            gridView = !gridView
            
        }
        paidOffersCollectionView.reloadData()
        
    }
    
    @IBAction func filterBtnTapped(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Home", bundle: nil)
        let filterVC = storiBoard.instantiateViewController(identifier: "FilterVC")
        self.navigationController?.pushViewController(filterVC, animated: true)
        
    }
    
    
}

extension PaidOffersListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if gridView {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaidOffersCollectionViewCell", for: indexPath)
        return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaidOffersVerticalCollectionViewCell", for: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if gridView {
            
        return CGSize(width: collectionView.frame.width / 2, height: 162)
            
        } else {
            
            return CGSize(width: collectionView.frame.width, height: 116)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let offerDetailsVC = storyBoard.instantiateViewController(identifier: "OfferDetailsVC")
        self.navigationController?.pushViewController(offerDetailsVC, animated: true)
    }
    
    
}
