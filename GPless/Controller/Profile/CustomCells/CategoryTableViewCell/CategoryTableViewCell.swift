//
//  CategoryTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryNameLbl: UILabel!
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    
    var offersArr = [OfferModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()

       
    }
    
    func setUpCollectionView() {
        
        favouriteCollectionView.delegate = self
        favouriteCollectionView.dataSource = self
        let nib = UINib(nibName: "PointsCollectionViewCell", bundle: nil)
        favouriteCollectionView.register(nib, forCellWithReuseIdentifier: "PointsCollectionViewCell")
        
    }
    
    func configureCell(points: PointsResponseOffer) {
        self.offersArr = points.offers!
        self.favouriteCollectionView.reloadData()
        self.categoryNameLbl.text = points.date!
    }


    
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offersArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PointsCollectionViewCell", for: indexPath) as! PointsCollectionViewCell
        cell.configureCell(offer: offersArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.width / 3)
    }
    
    
    
}
