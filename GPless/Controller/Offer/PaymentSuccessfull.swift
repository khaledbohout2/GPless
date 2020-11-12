//
//  PaymentSuccessfull.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class PaymentSuccessfull: UIViewController {
    
    @IBOutlet weak var paymentSuccessfullView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTopCornerRadius(myView: paymentSuccessfullView)
        
        self.navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    

    @IBAction func getOfferBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let pleaseLoginVC =  storyboard.instantiateViewController(identifier: "PleaseLoginVC")
        self.addChild(pleaseLoginVC)
        pleaseLoginVC.view.frame = self.view.frame
        self.view.addSubview((pleaseLoginVC.view)!)
        pleaseLoginVC.didMove(toParent: self)
    }
    

}
