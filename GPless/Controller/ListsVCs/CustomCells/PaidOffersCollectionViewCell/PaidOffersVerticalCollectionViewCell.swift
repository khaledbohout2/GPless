//
//  PaidOffersVerticalCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit
import Cosmos

class PaidOffersVerticalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLbl: UILabel!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var offerPointsLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var savedMoneyLbl: UILabel!
    @IBOutlet weak var priceBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func priceBtnTapped(_ sender: Any) {
        
    }
    
}
