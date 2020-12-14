//
//  paymentSuccesfullBranch.swift
//  GPless
//
//  Created by Khaled Bohout on 11/11/20.
//

import UIKit

class paymentSuccesfullBranch: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var paymentSuccessfullLbl: UILabel!
    
    @IBOutlet weak var congratulationsLbl: UILabel!
    
    @IBOutlet weak var tryAgianBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTopCornerRadius(myView: mainView)
        self.navigationController?.navigationBar.isHidden = true
        localize()

        // Do any additional setup after loading the view.
    }
    
    func localize() {

        paymentSuccessfullLbl.text = "paymentSuccessful".localizableString()
        congratulationsLbl.text = "Congratulations".localizableString()
        tryAgianBtn.setTitle("WilldoneAgain", for: .normal)
    }
    
    @IBAction func againBtnTapped(_ sender: Any) {
        
        //PaymentErrorVC
        
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let paymentErrorVC = storyBoard.instantiateViewController(identifier: "HomeVC")
        self.navigationController?.pushViewController(paymentErrorVC, animated: true)
        
    }
    

}
