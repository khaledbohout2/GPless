//
//  CategoriesSubTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class CategoriesSubTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    weak var delegate: VerticalCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
