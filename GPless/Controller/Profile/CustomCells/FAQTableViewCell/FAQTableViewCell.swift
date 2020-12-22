//
//  FAQTableViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/16/20.
//

import UIKit

class FAQTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(question: String, answers: [String]) {
        
        questionLbl.text = question
        answerLbl.text = answers.map { "- \($0)" }.joined(separator:"\n")
        
    }
    
}
