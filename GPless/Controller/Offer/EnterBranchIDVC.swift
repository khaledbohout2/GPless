//
//  EnterBranchID.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit
import KKPinCodeTextField

class EnterBranchIDVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var enterCodeBtn: UIButton!
    @IBOutlet weak var codeTxtField: KKPinCodeTextField!
    
    var keyBoardHeight: CGFloat?
    var height: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBottomCornerRadius(myView: mainView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
                self.height = keyboardSize.height
                self.enterCodeBtn.frame.origin.y -= height!
            
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {

        if self.height != nil {
            
            self.enterCodeBtn.frame.origin.y += self.height!
        }
        
        
    }
    
    
    @IBAction func enterBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let paymentSuccesfullBranch = storyBoard.instantiateViewController(identifier: "paymentSuccesfullBranch")
        self.navigationController?.pushViewController(paymentSuccesfullBranch, animated: true)
        
    }
    
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }

}
