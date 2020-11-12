//
//  verificationcodeVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/12/20.
//

import UIKit

class VerificationcodeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func enterCodeBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let enterNewPasswordVC = storyBoard.instantiateViewController(identifier: "EnterNewPasswordVC")
        self.navigationController?.pushViewController(enterNewPasswordVC, animated: true)
    }
    

}
