//
//  WelcomeVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import UIKit
import MOLH

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var useCurrentLocationBtn: UIButton!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var selectManuallyBtn: UIButton!
    @IBOutlet weak var chooseYourLocationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        localize()

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
    
    func localize() {
        
        useCurrentLocationBtn.setTitle("usecurrentlocation".localizableString(), for: .normal)
        useCurrentLocationBtn.setLocalization()
        
        welcomeLbl.text = "welcomToGPless".localizableString()
        welcomeLbl.setLocalization()
        
        
        let attributes: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.underlineStyle: 1,
            NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 17),
        NSAttributedString.Key.foregroundColor: hexStringToUIColor(hex: "#282828")
        ]

        let attributedString = NSMutableAttributedString(string: "selectitmanually".localizableString(), attributes: attributes)
        selectManuallyBtn.setAttributedTitle(NSAttributedString(attributedString: attributedString), for: .normal)

        chooseYourLocationLbl.text = "chooseLocation".localizableString()
        chooseYourLocationLbl.setLocalization()

    }


    @IBAction func useCurrntLocationBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let allowLocationVC =  storyboard.instantiateViewController(identifier: "AllowLocationVC") as? AllowLocationVC
        self.addChild(allowLocationVC!)
        allowLocationVC?.view.frame = self.view.frame
        self.view.addSubview((allowLocationVC?.view)!)
        allowLocationVC?.didMove(toParent: self)
        
    }
    
    
    @IBAction func setLocationManuallyBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let setLocationVC =  (storyboard.instantiateViewController(identifier: "SetLocationVC") as? SetLocationVC)!
        self.navigationController?.pushViewController(setLocationVC, animated: true)
    }
    

}
