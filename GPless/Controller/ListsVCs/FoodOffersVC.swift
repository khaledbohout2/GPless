//
//  FoodOffersVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/9/20.
//

import UIKit

class FoodOffersListVC: UIViewController {
    
    
    @IBOutlet weak var foodOffersCollectionView: UICollectionView!
    var gridView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()

    }
    
    func initCollectionView() {
        
        let hotOffersNib = UINib(nibName: "HotOffersCollectionViewCell", bundle: nil)
        let PaidOffersVerticalNib = UINib(nibName: "PaidOffersVerticalCollectionViewCell", bundle: nil)
        
        foodOffersCollectionView.register(hotOffersNib, forCellWithReuseIdentifier: "HotOffersCollectionViewCell")
        foodOffersCollectionView.register(PaidOffersVerticalNib, forCellWithReuseIdentifier: "PaidOffersVerticalCollectionViewCell")
        foodOffersCollectionView.delegate = self
        foodOffersCollectionView.dataSource = self

    }
    
    
    @IBAction func switchListingBtnTapped(_ sender: Any) {
        
        if gridView {
            
            if let flowLayout = foodOffersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .vertical
            }
            gridView = !gridView
            
        } else {
            
            if let flowLayout = foodOffersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
            }
            gridView = !gridView
            
        }
        foodOffersCollectionView.reloadData()
        
    }
    

    
    @IBAction func filterBtnTapped(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Home", bundle: nil)
        let filterVC = storiBoard.instantiateViewController(identifier: "FilterVC")
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    
    
}

extension FoodOffersListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if gridView {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotOffersCollectionViewCell", for: indexPath)
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
    
    
}
