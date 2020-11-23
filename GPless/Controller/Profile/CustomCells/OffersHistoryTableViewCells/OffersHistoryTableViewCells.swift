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
    
    @IBOutlet weak var reOrderBtn: UIButton!
    
    @IBOutlet weak var offerPriceLbl: UILabel!
    
    @IBOutlet weak var originalPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    @IBAction func reOrderBtnTapped(_ sender: Any) {
    }
    

    
}
