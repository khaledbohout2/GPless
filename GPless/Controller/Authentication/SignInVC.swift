//
//  SignInVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/11/20.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import SkyFloatingLabelTextField

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
        
        GIDSignIn.sharedInstance().delegate = self

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
        
        graphRequst.start { (connection, result, error) in
    
            if error != nil {
                
                print(error!)
                
            } else {
                
                print(result!)
                
                if let result = result as? [String:String]
                      {
                    let email = result["email"]
                    let fbId = result["id"]
                    let firstName = result["first_name"]
                    let lastName = result["last_name"]
                    
                     // internal usage of the email
                    self.signUp(fullName: firstName! + lastName!, accountType: "Normal", phone: "", address: "", loginMethod: "facebook", email: email!, password: fbId!, passwordConfirmation: fbId!)

                 }
            }
        }
    }
}

extension SignInVC: GIDSignInDelegate
{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
      let email = user.profile.email
      // ...
        signUp(fullName: fullName!, accountType: "Normal", phone: "", address: "", loginMethod: "google", email: email!, password: idToken!, passwordConfirmation: idToken!)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
}

extension SignInVC {
    
    func signUp(fullName: String, accountType: String, phone: String, address: String, loginMethod: String, email: String, password: String, passwordConfirmation: String) {
        
        let number = Int.random(in: 0..<10000)
        
        let newUser = UserToRegister(fullName: fullName, accountName: fullName + "\(number)", accountType: accountType, phone: phone, address: address, loginMethod: loginMethod, email: email, password: password, passwordConfirmation: passwordConfirmation)
        
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
        } else {
            
            Toast.show(message: "No Internet", controller: self)
        }
        
    }
}
