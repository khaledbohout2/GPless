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
    
    var ids: [Int]?
    var vendorCode: String?
    
    var keyBoardHeight: CGFloat?
    var height: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        
        makeBottomCornerRadius(myView: mainView)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")

        self.title = "Food Offers"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
      //  search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        

        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
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
        
        guard codeTxtField.text != "" else {
            Toast.show(message: "Please enter branch code", controller: self)
            return
        }
        
        self.vendorCode = codeTxtField.text
        
        confirmOffer()

    }
    
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }

}

extension EnterBranchIDVC {
    
    
    func confirmOffer() {
        
        print(self.ids!)
        print(self.vendorCode!)
        
        var confirmOffer = ConfirmOffer(ids: self.ids!, branchCode: "\(self.vendorCode!)")
        
        
        do {
            let jsonData = try JSONEncoder().encode(confirmOffer)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString) // [{"sentence":"Hello world","lang":"en"},{"sentence":"Hallo Welt","lang":"de"}]

            // and decode it back
            let decodedSentences = try JSONDecoder().decode(ConfirmOffer.self, from: jsonData)
            
            print(decodedSentences)
            
            confirmOffer = decodedSentences
            
        } catch { print(error) }
        
        _ = Network.request(req: ConfirmOfferRequest(confirmOffer: confirmOffer) , completionHandler: { (result) in
            switch result {
            case .success(let response):
                
                if response.error == nil {
                    print(response)
                    let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
                    let paymentSuccesfullBranch = storyBoard.instantiateViewController(identifier: "paymentSuccesfullBranch")
                    self.navigationController?.pushViewController(paymentSuccesfullBranch, animated: true)
                } else {
                    
                    print(response.error!)
                    
                    let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
                    let paymentErrorVC = storyBoard.instantiateViewController(identifier: "PaymentErrorVC")
                    self.navigationController?.pushViewController(paymentErrorVC, animated: true)
                }
            
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
}
