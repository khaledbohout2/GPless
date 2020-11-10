//
//  PleaseLogin.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class PleaseLoginVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTopCornerRadius(myView: mainView)
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        mainView.backgroundColor = UIColor(white: 1, alpha: 1.0)


        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let gotoBranch =  storyboard.instantiateViewController(identifier: "GoToBranchVC")
        self.addChild(gotoBranch)
        gotoBranch.view.frame = self.view.frame
        self.view.addSubview((gotoBranch.view)!)
        gotoBranch.didMove(toParent: self)
    }
    
    



}
