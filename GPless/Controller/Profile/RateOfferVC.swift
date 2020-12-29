//
//  RateOfferVC.swift
//  GPless
//
//  Created by Khaled Bohout on 12/7/20.
//

import UIKit
import Cosmos

class RateOfferVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var rateView: CosmosView!
    
    @IBOutlet weak var howToFindYourOfferLbl: UILabel!
    @IBOutlet weak var rateBtn: UIButton!
    
    var offer: OfferModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        mainView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        setCosmosView()
        localize()

        // Do any additional setup after loading the view.
    }
    
    func localize() {
        
        howToFindYourOfferLbl.text = "howYouFindYourOffer".localizableString()
        howToFindYourOfferLbl.setLocalization()
        rateBtn.setTitle("Rate", for: .normal)
        rateBtn.setLocalization()
        
    }
    
    @IBAction func rateBtnTapped(_ sender: Any) {
        
        if Reachable.isConnectedToNetwork() {
        
        rateRequest()
            
        } else {
            
            Toast.show(message: "noInternet".localizableString(), controller: self)
        }
    }
    
    func setCosmosView() {
        
        rateView.didFinishTouchingCosmos = { rating in
            print(rating)
        }
    }
}

extension RateOfferVC {
    
    func rateRequest() {
        _ = Network.request(req: RateOfferRequest(id: "\(self.offer.id!)", value: "\(self.rateView.rating)"), completionHandler: { (result) in
            switch result {
            case .success(let response):
                print(response)
                Toast.show(message: "doneRating".localizableString(), controller: self)
                self.view.removeFromSuperview()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
}
