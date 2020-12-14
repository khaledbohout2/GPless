//
//  PaymentErrorVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/11/20.
//

import UIKit

class PaymentErrorVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var paymentErrorLbl: UILabel!
    @IBOutlet weak var paymentErrorPleaseLbl: UILabel!
    @IBOutlet weak var tryAgain: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeTopCornerRadius(myView: mainView)
        self.navigationController?.navigationBar.isHidden = true
        localize()
    }
    
    func localize() {

        paymentErrorLbl.text = "paymentError".localizableString()
        paymentErrorPleaseLbl.text = "paymenttryagainlater".localizableString()
        tryAgain.setTitle("tryAgain".localizableString(), for: .normal)
    }
    

    @IBAction func tryAgianBtnTapped(_ sender: Any) {
        
        // OrderSuccesfullVC
        
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let orderSuccesfullVC = storyBoard.instantiateViewController(identifier: "OrderSuccesfullVC")
        self.navigationController?.pushViewController(orderSuccesfullVC, animated: true)
        
    }
    

}
