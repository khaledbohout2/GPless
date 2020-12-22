//
//  TermsAndConditionsVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/17/20.
//

import UIKit

class TermsAndConditionsVC: UIViewController {

    @IBOutlet weak var termsAndConditionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        termsAndConditionsTextView.text = SharedSettings.shared.settings?.termsAndCondition

        // Do any additional setup after loading the view.
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.title = "termsAndConditions".localizableString()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
     //   search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        

        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    




}
