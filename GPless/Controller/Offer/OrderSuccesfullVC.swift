//
//  OrderSuccesfullVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/11/20.
//

import UIKit

class OrderSuccesfullVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var youGetOffersLbl: UILabel!
    @IBOutlet weak var congratulationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTopCornerRadius(myView: mainView)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func localize() {
        
        youGetOffersLbl.text = "Congratulations".localizableString()
        congratulationLbl.text = "".localizableString()
    }
    
    
    @IBAction func tryAgianBtnTapped(_ sender: Any) {
        
        //SignInVC
        
        let storyBoard = UIStoryboard(name: "Authentication", bundle: nil)
        let signInVC = storyBoard.instantiateViewController(identifier: "SignInVC")
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    



}
