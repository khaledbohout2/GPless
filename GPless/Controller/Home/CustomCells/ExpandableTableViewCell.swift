//
//  ExpandableTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/5/20.
//

import UIKit

class ExpandableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var radioBtn: DLRadioButton!
    
    var delegate: CheckRadioBtnProtocol!
    var index: IndexPath!
    var tableView: UITableView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func radioButtonAction(_ sender: DLRadioButton) {
        
        self.delegate?.checkBtn(index: self.index, tableView: self.tableView)

    }
}

protocol CheckRadioBtnProtocol {
    
    func checkBtn(index: IndexPath, tableView: UITableView)
}
