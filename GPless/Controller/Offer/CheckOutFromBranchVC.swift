//
//  CheckOutFromBranch.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class CheckOutFromBranchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let enterBranchIDVC = storyBoard.instantiateViewController(identifier: "EnterBranchIDVC")
        self.navigationController?.pushViewController(enterBranchIDVC, animated: true)
        
    }
    


}
