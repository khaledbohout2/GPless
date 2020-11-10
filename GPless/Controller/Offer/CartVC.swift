//
//  CartVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var countLbl: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var itemDataView: UIView!
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    
    @IBOutlet weak var footerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeBottomCornerRadius(myView: headerView)
        makeTopCornerRadius(myView: footerView)
       // installOpacity()

        // Do any additional setup after loading the view.
    }
    
    func installOpacity() {
        
        itemDataView.layer.shadowColor = hexStringToUIColor(hex: "#00000033").cgColor
        itemDataView.layer.shadowOpacity = 1
        itemDataView.layer.shadowOffset = CGSize(width: 0, height: 2)
        itemDataView.layer.shadowRadius = 4
        
        itemImageView.layer.shadowColor = hexStringToUIColor(hex: "#00000033").cgColor
        itemImageView.layer.shadowOpacity = 1
        itemImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        itemImageView.layer.shadowRadius = 4
    }
    


    @IBAction func minusBtnTapped(_ sender: Any) {
        
        var count = Int(countLbl.text!)!
        if count > 1 {
            count -= 1
            self.countLbl.text = String(count)
        }
    }
    
    @IBAction func plusBtnTapped(_ sender: Any) {
        
        var count = Int(countLbl.text!)!
        
            count += 1
            self.countLbl.text = String(count)
        
        
    }
    
    @IBAction func payOfferBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let paymentSuccessfull = storyBoard.instantiateViewController(identifier: "PaymentSuccessfull")
        self.navigationController?.pushViewController(paymentSuccessfull, animated: true)
    }
    
}
