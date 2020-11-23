//
//  OffersCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/2/20.
//

import UIKit

class OffersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var offerImageView: UIImageView!
    
    @IBOutlet weak var offerDescriptionLbl: UILabel!
    
    @IBOutlet weak var offerShopLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(offer: OfferModel) {
        self.offerDescriptionLbl.text = offer.name
        self.offerShopLbl.text = "\(offer.vendorID!)"
        
    }
    
    
    @IBAction func detailsButtonTapped(_ sender: Any) {
        
    }
    
}


