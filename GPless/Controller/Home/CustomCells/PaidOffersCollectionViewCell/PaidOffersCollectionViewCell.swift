//
//  PaidOffersCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/3/20.
//

import UIKit

class PaidOffersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var offerImageView: UIImageView!
    
    @IBOutlet weak var offerTitleLbl: UILabel!
    @IBOutlet weak var timeLeftLbl: UILabel!
    
    @IBOutlet weak var storeNameLbl: UILabel!
    
    @IBOutlet weak var priceBtnTapped: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
