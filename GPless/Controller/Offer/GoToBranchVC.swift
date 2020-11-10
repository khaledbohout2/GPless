//
//  GoToBranchVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class GoToBranchVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        mainView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        makeTopCornerRadius(myView: mainView)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func gotoBranchBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let checkOutFromBranchVC = storyBoard.instantiateViewController(identifier: "CheckOutFromBranchVC")
        self.navigationController?.pushViewController(checkOutFromBranchVC, animated: true)
        
    }
    



}
