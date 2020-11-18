//
//  WelcomeVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import UIKit

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var useCurrentLocationBtn: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        

        

        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
        
        makeMainTopCornerRadius(myView: mainView)
        self.view.backgroundColor = hexStringToUIColor(hex: "#FBE159")
        self.navigationController?.navigationBar.isHidden = true

    }
    
    func makeMainTopCornerRadius(myView: UIView) {
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = myView.frame
        rectShape.position = myView.center
        rectShape.path = UIBezierPath(roundedRect: myView.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 75, height: 75)).cgPath

         myView.layer.mask = rectShape
    }

    

    @IBAction func useCurrntLocationBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let allowLocationVC =  storyboard.instantiateViewController(identifier: "AllowLocationVC") as? AllowLocationVC
        self.addChild(allowLocationVC!)
        allowLocationVC?.view.frame = self.view.frame
        self.view.addSubview((allowLocationVC?.view)!)
        allowLocationVC?.didMove(toParent: self)
        
    }


}
