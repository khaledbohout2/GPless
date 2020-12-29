//
//  OffersCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/2/20.
//

import UIKit

protocol GotoOfferDetails {
    
    func gotoOfferDetails(id: String)
}

class OffersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerDescriptionLbl: UILabel!
    @IBOutlet weak var offerShopLbl: UILabel!
    
    var offer: OfferModel?
    var delegate: GotoOfferDetails?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(offer: OfferModel) {
        
        self.offerDescriptionLbl.text = offer.name
        self.offerShopLbl.text = "\(offer.vendorID!)"
        self.offer = offer
        
    }
    
    
    @IBAction func detailsButtonTapped(_ sender: Any) {
        
        self.delegate!.gotoOfferDetails(id: "\(offer!.id)")
    }
    
}


