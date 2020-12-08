//
//  SignUpMobile.swift
//  GPless
//
//  Created by Khaled Bohout on 11/12/20.
//

import UIKit

class SignUpMobile: UIViewController {
    
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    


    @IBAction func enterMobileBtnTapped(_ sender: Any) {
        
        guard phoneNumberTextField.text != "" else {
            return
        }
        
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let signUpVC = storyBoard.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        signUpVC.mobile = phoneNumberTextField.text
        self.navigationController?.pushViewController(signUpVC, animated: true)
        
    }
    
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let signInVC = storyBoard.instantiateViewController(identifier: "SignInVC") as! SignInVC
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
}
