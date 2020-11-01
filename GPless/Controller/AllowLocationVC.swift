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
            let setLocationVC =  (storyboard.instantiateViewController(identifier: "SearchResultsVC") as? SearchResultsVC)!
            self.navigationController?.pushViewController(setLocationVC, animated: true)
        
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
