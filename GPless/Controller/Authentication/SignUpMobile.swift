//
//  SignUpMobile.swift
//  GPless
//
//  Created by Khaled Bohout on 11/12/20.
//

import UIKit

class SignUpMobile: UIViewController {
    
    @IBOutlet weak var welcomToGPLess: UILabel!
    @IBOutlet weak var welcomeDetailsLBL: UILabel!
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var phoneNumTXF: UITextField!
    @IBOutlet weak var byContinueLbl: UILabel!
    @IBOutlet weak var alreadyHaveAcountLbl: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        localize()

        // Do any additional setup after loading the view.
    }
    
    func localize() {
        
        welcomToGPLess.text = "welcomeToGPLess".localizableString()
        welcomeDetailsLBL.text = "welcometoGpless".localizableString()
        signUpLbl.text = "signup".localizableString()
        phoneNumberLbl.text = "phoneNumber".localizableString()
        phoneNumTXF.placeholder = "phoneNumber".localizableString()
        byContinueLbl.text = "continueReceiveVerificationcode".localizableString()
        alreadyHaveAcountLbl.text = "alreadyHaveAccount".localizableString()
        signInBtn.setTitle("signin".localizableString(), for: .normal)
        phoneNumberTextField.placeholder = "phoneNumber".localizableString()
        
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
