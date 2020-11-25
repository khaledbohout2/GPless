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
    
    func congigureCell(category: CategoryElement) {
        
        let opacity:CGFloat = 0.25
        
        let backgroundColor =  hexStringToUIColor(hex: "#C5C1C1")
        
        self.categoryView.backgroundColor = backgroundColor.withAlphaComponent(opacity)
        self.nameLbl.text = category.categoryName
        
    }

}
