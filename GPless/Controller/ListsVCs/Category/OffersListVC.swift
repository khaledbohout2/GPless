//
//  OffersListVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class OffersListVC: UIViewController {

    @IBOutlet weak var offersCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()

        // Do any additional setup after loading the view.
    }
    

    func setUpCollectionView() {
        
        offersCollectionView.delegate = self
        offersCollectionView.dataSource = self
        
        let hotOffersNib = UINib(nibName: "HotOffersCollectionViewCell", bundle: nil)
        offersCollectionView.register(hotOffersNib, forCellWithReuseIdentifier: "HotOffersCollectionViewCell")
        offersCollectionView.delegate = self
        offersCollectionView.dataSource = self
    }
    
    

}

extension OffersListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
