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
        checkMobile()

        // Do any additional setup after loading the view.
    }
    
    func localize() {
        
        welcomToGPLess.text = "welcomeToGPLess".localizableString()
        welcomToGPLess.setLocalization()
        
        welcomeDetailsLBL.text = "welcometoGpless".localizableString()
        welcomeDetailsLBL.setLocalization()
        
        signUpLbl.text = "signup".localizableString()
        signUpLbl.setLocalization()
        
        phoneNumberLbl.text = "PhoneNumber".localizableString()
        phoneNumberLbl.setLocalization()
        
       // phoneNumTXF.placeholder = "PhoneNumber".localizableString()
       // phoneNumTXF.setLocalization()
        
        byContinueLbl.text = "continueReceiveVerificationcode".localizableString()
        byContinueLbl.setLocalization()
        
        alreadyHaveAcountLbl.text = "alreadyHaveAccount".localizableString()
        alreadyHaveAcountLbl.setLocalization()
        
        signInBtn.setTitle("signin".localizableString(), for: .normal)
        signInBtn.setLocalization()
        
        phoneNumberTextField.placeholder = "phoneNumber".localizableString()
       // phoneNumberTextField.setLocalization()
        
    }
    


    @IBAction func enterMobileBtnTapped(_ sender: Any) {
        
        guard phoneNumberTextField.text != "" else {
            return
        }
        
        if Reachable.isConnectedToNetwork() {

        checkMobile()

        } else {

            Toast.show(message: "noInternet".localizableString(), controller: self)
        }
        
    }
    
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let signInVC = storyBoard.instantiateViewController(identifier: "SignInVC") as! SignInVC
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
}

extension SignUpMobile {
    
    func checkMobile() {
        
        _ = Network.request(req: CheckMobileRequest(mobile: phoneNumberTextField.text!), completionHandler: { (result) in
            switch result {
            
            case .success(let success):
                print(success)
                
                if success == 1 {
                    
                    let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
                    let signUpVC = storyBoard.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
                    signUpVC.mobile = self.phoneNumberTextField.text
                    self.navigationController?.pushViewController(signUpVC, animated: true)
                    
                } else {
                    
                    Toast.show(message: "mobileExisted".localizableString(), controller: self)
                }
                
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
        
    }
    
    
}
