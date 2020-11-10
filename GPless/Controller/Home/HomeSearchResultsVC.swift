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
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpCollectionView()
        
        
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.0)
        mainView.backgroundColor = UIColor(white: 1, alpha: 0.0)
            self.navigationController?.navigationBar.isHidden = true
            
            let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismisSearch))
            self.mainView.addGestureRecognizer(dismissGesture)
        
      //  self.searchView.backgroundColor = UIColor(white: 1, alpha: 1.0)



        // Do any additional setup after loading the view.
    }
    
    @objc func dismisSearch() {
        
        self.view.removeFromSuperview()
        
        
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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotOffersCollectionViewCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 173, height: 162)
    }
    
    
}
