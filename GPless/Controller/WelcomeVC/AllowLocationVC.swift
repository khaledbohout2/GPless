//
//  AllowLocationVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import UIKit

class AllowLocationVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.3)
        self.mainView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        

        // Do any additional setup after loading the view.
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
