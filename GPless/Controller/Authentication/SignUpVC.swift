//
//  SignUpVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/12/20.
//

import UIKit
import SkyFloatingLabelTextField

class SignUpVC: UIViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var invitationCodeTxtField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var continueBtn: UIButton!
    
    var mobile: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
        
        makeBottomCornerRadius(myView: headerImageView)
        self.navigationController?.navigationBar.isHidden = true
        continueBtn.setTitle("continue".localizableString(), for: .normal)

        // Do any additional setup after loading the view.
    }
    
    func localize() {
        
        continueBtn.setTitle("continue".localizableString(), for: .normal)
        continueBtn.setLocalization()
        
        nameTextField.placeholder = "name".localizableString()
       // nameTextField.setLocalization()
        
        emailTextField.placeholder = "email".localizableString()
      //  emailTextField.setLocalization()
        
        passwordTextField.placeholder = "password".localizableString()
      //  passwordTextField.setLocalization()
        
        invitationCodeTxtField.placeholder = "invitationCode".localizableString()
      //  invitationCodeTxtField.setLocalization()
    }
    
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        
        guard nameTextField.text != ""  else {
            Toast.show(message: "PleaseEnterYourName".localizableString(), controller: self)
            return
        }
        guard passwordTextField.text != ""  else {
            Toast.show(message: "pleaseEnterYourPassword".localizableString(), controller: self)
            return
        }
        
        guard emailTextField.text != ""  else {
            Toast.show(message: "pleaseEnterYourMail".localizableString(), controller: self)
            return
        }
        
        if Reachable.isConnectedToNetwork() {
            
        sugnUp()
            
        } else {
            
            Toast.show(message: "noInternet".localizableString(), controller: self)
        }
    }
    
}

extension SignUpVC {
    
    func sugnUp() {
        
        let number = Int.random(in: 0..<10000)
        
        let newUser = UserToRegister(fullName: nameTextField.text, accountName: nameTextField.text! + "\(number)" , accountType: "Normal", phone: self.mobile, address: "", loginMethod: "", email: emailTextField.text, password: passwordTextField.text, passwordConfirmation: passwordTextField.text)
        
        print(newUser)
        
        _ = Network.request(req: RegisterRequest(user: newUser)) { (result) in
            switch result {
            case .success(let user):
                print(user)
                //SelectMembershipVC
                if user.error != nil {
                    Toast.show(message: user.error!, controller: self)

                } else {
                    
                    setUserData(user: user)
                    if user.permuim == 0 {
                        setUserType(userType: "0")
                    } else if user.permuim == 1 {
                        setUserType(userType: "1")
                    }
                    
                    print(user.tokens!.accessToken!)
                    let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
                    let selectMembershipVC = storyBoard.instantiateViewController(identifier: "SelectMembershipVC") as! SelectMembershipVC
                    self.navigationController?.pushViewController(selectMembershipVC, animated: true)
                }
                
            case .cancel(let cancelError):
            print(cancelError!)
            case .failure(let error):
            print(error!)
            
            }
        }
    }
}

