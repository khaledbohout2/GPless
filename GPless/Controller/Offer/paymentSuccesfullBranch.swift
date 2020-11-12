//
//  paymentSuccesfullBranch.swift
//  GPless
//
//  Created by Khaled Bohout on 11/11/20.
//

import UIKit

class paymentSuccesfullBranch: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTopCornerRadius(myView: mainView)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func againBtnTapped(_ sender: Any) {
        
        //PaymentErrorVC
        
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let paymentErrorVC = storyBoard.instantiateViewController(identifier: "PaymentErrorVC")
        self.navigationController?.pushViewController(paymentErrorVC, animated: true)
        
    }
    

}
