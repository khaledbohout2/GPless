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
        
        sugnUp()
        
        
    }
    
}

extension SignUpVC {
    
    func sugnUp() {
        
        let newUser = UserToRegister(fullName: nameTextField.text, accountName: "", accountType: "", phone: self.mobile, address: "", loginMethod: "", email: emailTextField.text, photoLink: "", password: passwordTextField.text, passwordConfirmation: passwordTextField.text)
        
        print(newUser)
        
        _ = Network.request(req: RegisterRequest(user: newUser)) { (result) in
            switch result {
            case .success(let user):
                print(user)
                //SelectMembershipVC
                let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
                let selectMembershipVC = storyBoard.instantiateViewController(identifier: "SelectMembershipVC")
                self.navigationController?.pushViewController(selectMembershipVC, animated: true)
            case .cancel(let cancelError):
            print(cancelError!)
            case .failure(let error):
            print(error!)
            
            }
        }
    }
}
