//
//  DoneContactUsVC.swift
//  GPless
//
//  Created by Khaled Bohout on 28/12/2020.
//

import UIKit

class DoneContactUsVC: UIViewController {

    @IBOutlet weak var thanksMessageLbl: UILabel!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        mainView.backgroundColor = UIColor(white: 1, alpha: 1.0)
    }
    

    @IBAction func doneBtnTapped(_ sender: Any) {
        
        self.view.removeFromSuperview()
        
    }
    
}
