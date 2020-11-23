//
//  PointsCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class PointsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageImageView: UIImageView!
    
    @IBOutlet weak var offerDetailsLbl: UILabel!
    
    @IBOutlet weak var pointsCountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
