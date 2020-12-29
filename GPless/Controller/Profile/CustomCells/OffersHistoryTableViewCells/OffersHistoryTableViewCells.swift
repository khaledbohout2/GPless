//
//  OffersHistoryTableViewCells.swift
//  GPless
//
//  Created by Khaled Bohout on 11/16/20.
//

import UIKit

class OffersHistoryTableViewCells: UITableViewCell {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerNameLbl: UILabel!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var savedMoneyLbl: UILabel!
    @IBOutlet weak var offerPriceLbl: UILabel!
    @IBOutlet weak var originalPriceLbl: UILabel!
    
    var offer: OfferModel!
    
    var delegate: OffersHistoryProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(offer: OfferModel) {
        
        self.offer = offer
        
        let baseOfferLink = SharedSettings.shared.settings?.offersLink ?? ""
        
        let imageLink = offer.imageLink ?? ""
        
        self.offerImageView.sd_setImage(with: URL(string: baseOfferLink + "/" + imageLink))
        self.offerNameLbl.text = offer.name
        self.offerNameLbl.setLocalization()
        
        self.storeNameLbl.text = offer.vendorName
        self.storeNameLbl.setLocalization()
        
        self.savedMoneyLbl.text = "\(offer.priceBeforeDiscount! - offer.priceAfterDiscount!)"
        self.savedMoneyLbl.setLocalization()
        
        self.offerPriceLbl.text = "\(offer.priceAfterDiscount!)"
        self.offerPriceLbl.setLocalization()
        
        self.originalPriceLbl.text = "\(offer.priceBeforeDiscount!)"
        self.originalPriceLbl.setLocalization()
    }
    
    @IBAction func rateBtnTapped(_ sender: Any) {
        self.delegate?.rate(offer: self.offer)
    }
    
}

protocol OffersHistoryProtocol {
    
    func reorder(offer: OfferModel)
    func rate(offer: OfferModel)
}
