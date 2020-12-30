//
//  HomeSearchResultsVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/4/20.
//

import UIKit

class HomeSearchResultsVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var collectionViewContainerView: UIView!
    @IBOutlet weak var searchResultsCollectionView: UICollectionView!
    
    
    var offersArr = [OfferModel]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpCollectionView()
        
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.0)
        mainView.backgroundColor = UIColor(white: 1, alpha: 0.0)
            self.navigationController?.navigationBar.isHidden = true
            
            let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismisSearch))
            self.mainView.addGestureRecognizer(dismissGesture)
        
      //  self.searchView.backgroundColor = UIColor(white: 1, alpha: 1.0)
    }
    
    @objc func dismisSearch() {
        
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let offersListVC =  storyboard.instantiateViewController(identifier: "HomeVC") as! HomeVC
        self.navigationController?.popToViewController(offersListVC, animated: true)
        
        
    }
    
    func setUpCollectionView() {
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        
        let hotOffersNib = UINib(nibName: "HotOffersCollectionViewCell", bundle: nil)
        searchResultsCollectionView.register(hotOffersNib, forCellWithReuseIdentifier: "HotOffersCollectionViewCell")
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    

}

extension HomeSearchResultsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offersArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotOffersCollectionViewCell", for: indexPath) as! HotOffersCollectionViewCell
        cell.configureCell(offer: offersArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width / 2, height: collectionView.frame.size.width / 2)
    }
    
    
}
