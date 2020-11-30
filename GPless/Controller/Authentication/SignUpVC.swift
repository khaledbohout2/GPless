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
    
    var mobile: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBottomCornerRadius(myView: headerImageView)
        self.navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        
        guard nameTextField.text != ""  else {
            Toast.show(message: "please enter your name", controller: self)
            return
        }
        guard passwordTextField.text != ""  else {
            Toast.show(message: "please enter password", controller: self)
            return
        }
        
        guard emailTextField.text != ""  else {
            Toast.show(message: "please enter email", controller: self)
            return
        }

        
        sugnUp()
        
    }
    
}

extension SignUpVC {
    
    func sugnUp() {
        
        let number = Int.random(in: 0..<10000)
        
        let newUser = UserToRegister(fullName: nameTextField.text, accountName: nameTextField.text! + "\(number)" , accountType: "Normal", phone: self.mobile, address: "", loginMethod: "", email: emailTextField.text, password: passwordTextField.text, passwordConfirmation: passwordTextField.text)
        
        print(newUser)
        
        if Reachable.isConnectedToNetwork() {
        
        _ = Network.request(req: RegisterRequest(user: newUser)) { (result) in
            switch result {
            case .success(let user):
                print(user)
                //SelectMembershipVC
                if user.error != nil {
                    Toast.show(message: user.error!, controller: self)

                } else {
                    setUserData(user: user)
                    print(user.tokens?.accessToken)
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
        } else {
            Toast.show(message: "No Internet", controller: self)
        }
    }
}

