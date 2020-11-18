//
//  PaymentErrorVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/11/20.
//

import UIKit

class PaymentErrorVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeTopCornerRadius(myView: mainView)
        self.navigationController?.navigationBar.isHidden = true
    }
    

    @IBAction func tryAgianBtnTapped(_ sender: Any) {
        
        // OrderSuccesfullVC
        
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let orderSuccesfullVC = storyBoard.instantiateViewController(identifier: "OrderSuccesfullVC")
        self.navigationController?.pushViewController(orderSuccesfullVC, animated: true)
        
    }
    

}
