//
//  SignInVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/11/20.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var signInBtn: UIButton!
    
    
    
    
    var keyBoardHeight: CGFloat?
    var height: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNotification()
        self.navigationController?.navigationBar.isHidden = true
        makeTopCornerRadius(myView: mainView)
        
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()

        // ...

        // Do any additional setup after loading the view.
    }
    
    func registerNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            self.view.frame.origin.y = 0 - keyboardSize.height + 150
            self.signInBtn.frame.origin.y = 0 - keyboardSize.height + 135
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
            
            self.view.frame.origin.y = 0
        self.signInBtn.frame.origin.y = -30.0
    }
    
    deinit {
        
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let forgotPasswordVC = storyBoard.instantiateViewController(identifier: "ForgotPasswordVC")
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    
    @IBAction func signInWithGoogle(_ sender: Any) {
    }
    
    
    @IBAction func signInWithFacebook(_ sender: Any) {
        
        let facebooklogin = LoginManager()
      
         
        facebooklogin.logIn(permissions: ["public_profile","email"], viewController: self) { (result) in
            if result != nil {
                
                self.fetchProfile()
                
            }
        }
        
    }
    
    
    
    @IBAction func signInWithApple(_ sender: Any) {
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        
      GIDSignIn.sharedInstance().signOut()
        
    }
    
    func fetchProfile() {
    
        let parameters = ["fields": "email, first_name, last_name, birthday, gender, picture.type(large)"]
        let graphRequst = GraphRequest(graphPath: "me", parameters: parameters)
        graphRequst.start { (connection, Result, error) in
    
            if error != nil {
                print(error)
            } else {
                print(Result)
            }
    
        }
    }
    
    
}
