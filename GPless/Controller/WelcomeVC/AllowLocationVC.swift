//
//  AllowLocationVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import UIKit

class AllowLocationVC: UIViewController {
    
    @IBOutlet weak var AllowLocationLbl: UILabel!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
        
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.3)
        self.mainView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        

        // Do any additional setup after loading the view.
    }
    
    func localize() {
        
        AllowLocationLbl.text = "allowGpless".localizableString()
        yesBtn.setTitle("yes".localizableString(), for: .normal)
        noBtn.setTitle("no".localizableString(), for: .normal)
    }

    @IBAction func noBtnTapped(_ sender: Any) {
        
        self.view.removeFromSuperview()
        
    }
    
    @IBAction func yesBtnTapped(_ sender: Any) {
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let searchResultsVC =  (storyboard.instantiateViewController(identifier: "SearchResultsVC") as? SearchResultsVC)!
            self.navigationController?.pushViewController(searchResultsVC, animated: true)
        
    }
    

}
