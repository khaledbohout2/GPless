//
//  SignUpMobile.swift
//  GPless
//
//  Created by Khaled Bohout on 11/12/20.
//

import UIKit

class SignUpMobile: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    


    @IBAction func enterMobileBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let signUpVC = storyBoard.instantiateViewController(identifier: "SignUpVC")
        self.navigationController?.pushViewController(signUpVC, animated: true)
        
    }
    
}
