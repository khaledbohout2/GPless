//
//  EnterNewPasswordVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/12/20.
//

import UIKit

class EnterNewPasswordVC: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBottomCornerRadius(myView: headerView)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        
     //   SignUpMobile
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let signUpMobile = storyBoard.instantiateViewController(identifier: "SignUpMobile")
        self.navigationController?.pushViewController(signUpMobile, animated: true)
        
    }
    
}
