//
//  ForgotPasswordVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/11/20.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var iconImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var iconImageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var enterBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTopCornerRadius(myView: mainView)
        registerNotification()

        // Do any additional setup after loading the view.
    }
    
    func registerNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            self.view.frame.origin.y = 0 - keyboardSize.height
            self.iconImageViewWidth.constant = 128
            self.iconImageViewHeight.constant = 128
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
            
            self.view.frame.origin.y = 0
        self.iconImageViewWidth.constant = 200
        self.iconImageViewHeight.constant = 200
    }
    
    deinit {
        
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }
    

    @IBAction func enterBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let verificationcodeVC = storyBoard.instantiateViewController(identifier: "VerificationcodeVC")
        self.navigationController?.pushViewController(verificationcodeVC, animated: true)
        
    }
    

}
