//
//  SearchCategoryCVCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import UIKit

class SearchCategoryCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var categoryView: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func congigureCell(category: SearchCategory) {
        
        self.categoryView.backgroundColor = hexStringToUIColor(hex: category.color)
        self.nameLbl.text = category.text
        
    }

}
