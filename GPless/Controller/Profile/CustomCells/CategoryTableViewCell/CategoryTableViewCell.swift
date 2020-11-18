//
//  CategoryTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        favouriteCollectionView.delegate = self
        favouriteCollectionView.dataSource = self
        let nib = UINib(nibName: "PointsCollectionViewCell", bundle: nil)
        favouriteCollectionView.register(nib, forCellWithReuseIdentifier: "PointsCollectionViewCell")
       
    }


    
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PointsCollectionViewCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.width / 3)
    }
    
    
    
}
