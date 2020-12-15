//
//  ChangePasswordPopUpVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class ChangePasswordPopUpVC: UIViewController {
    
    @IBOutlet weak var yourPassChangedLbl: UILabel!
    
    @IBOutlet weak var doneLbl: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        localize()
    }
    
    func localize() {
       
        yourPassChangedLbl.text = "yourPasswordHaschanged".localizableString()
        
        doneLbl.setTitle("done".localizableString(), for: .normal)
    }
    

}
