//
//  SearchCategoryCVCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import UIKit

class SearchCategoryCVCell: UICollectionViewCell {
    
    let colorsArr = ["#F6C677", "#3A9082", "#E95FA4"]
    
    @IBOutlet weak var categoryView: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func congigureCell(category: CategoryElement) {
        
        let opacity:CGFloat = 0.25
        
        let backgroundColor =  hexStringToUIColor(hex: category.colorCode ?? "")
        
        self.categoryView.backgroundColor = backgroundColor.withAlphaComponent(opacity)
        
        self.nameLbl.text = category.categoryName
        
    }

}
