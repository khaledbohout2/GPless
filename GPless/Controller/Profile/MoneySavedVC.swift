//
//  MoneySavedVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/17/20.
//

import UIKit

class MoneySavedVC: UIViewController {

    @IBOutlet weak var offersHistoryTableView: UITableView!
    @IBOutlet weak var moneySavedLbl: UILabel!
    
    @IBOutlet weak var totalSavingLbl: UILabel!
 //   @IBOutlet weak var offerHistoryLbl: UILabel!
    
    var offersHistory = [OffersHistoryOffer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        setUpNavigation()
        localize()
        
        if Reachable.isConnectedToNetwork() {
            
        getMoneySaved()
        getOffersHistory()
            
        }

        // Do any additional setup after loading the view.
    }
    
    func localize() {
        
        totalSavingLbl.text = "totalSaving".localizableString()
        totalSavingLbl.setLocalization()
      //  offerHistoryLbl.text = "offersHistory".localizableString()
        //   offerHistoryLbl.setLocalization()

    }
    
    
    func initTableView() {
        
        offersHistoryTableView.delegate = self
        offersHistoryTableView.dataSource = self
        let nib = UINib(nibName: "OffersHistoryTableViewCells", bundle: nil)
        offersHistoryTableView.register(nib, forCellReuseIdentifier: "OffersHistoryTableViewCells")
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")

        self.title = "moneySaved".localizableString()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft".localizableString())
        back.tintColor = hexStringToUIColor(hex: "#000000")
        navigationItem.leftBarButtonItem = back
        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pendingOffersBtnTapped(_ sender: Any) {
    }
    
    @IBAction func offersHistoryBtnTapped(_ sender: Any) {
    }
    

}

extension MoneySavedVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return offersHistory.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return offersHistory[section].date
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let label = UILabel()
        
        label.textColor = hexStringToUIColor(hex: "#939393")
        
        label.text = "    \(offersHistory[section].date!)"
        
        label.font = UIFont(name: "Segoe UI-Regular", size: 12)

        return label

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersHistory[section].offers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = tableView.indexPathsForVisibleRows?.first?.section
        let cell = tableView.dequeueReusableCell(withIdentifier: "OffersHistoryTableViewCells", for: indexPath) as! OffersHistoryTableViewCells
        cell.delegate = self
        let offer = offersHistory[index!].offers![indexPath.row]
        cell.configureCell(offer: offer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let offerDetailsVC = storyBoard.instantiateViewController(identifier: "OfferDetailsVC") as! OfferDetailsVC
        let index = tableView.indexPathsForVisibleRows?.first?.section
        offerDetailsVC.id = "\(offersHistory[index!].offers![indexPath.row].id)"
        self.navigationController?.pushViewController(offerDetailsVC, animated: true)

    }
    
}

extension MoneySavedVC {
    
    func getMoneySaved() {
        
        _ = Network.request(req: GetMoneySavedRequest(), completionHandler: { (result) in
            switch result {
            case .success(let moneySaved):
                print(moneySaved!)
                self.moneySavedLbl.text = "\(moneySaved!)"
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
    
    func getOffersHistory() {
        
        _ = Network.request(req: GetUserOffersRequest(), completionHandler: { (result) in
            switch result {
            case .success(let offers):
                print(offers)
                self.offersHistory = offers.offers!
                self.offersHistoryTableView.reloadData()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
    
    func getPendingOffers() {
        
        _ = Network.request(req: GetUserOffersRequest(), completionHandler: { (result) in
            switch result {
            case .success(let offers):
                print(offers)
                self.offersHistory = offers.offers!
                self.offersHistoryTableView.reloadData()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
}

extension MoneySavedVC: OffersHistoryProtocol {
    
    func reorder(offer: OfferModel) {
        
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let rateOfferVC =  storyboard.instantiateViewController(identifier: "RateOfferVC") as! RateOfferVC
        rateOfferVC.offer = offer
        self.addChild(rateOfferVC)
        rateOfferVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview((rateOfferVC.view)!)
        rateOfferVC.didMove(toParent: self)
            
            self.view.addConstraints([
                NSLayoutConstraint(item: rateOfferVC.view!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: rateOfferVC.view!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: rateOfferVC.view!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: rateOfferVC.view!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
                ])
    }
    
    func rate(offer: OfferModel) {
        
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let rateOfferVC =  storyboard.instantiateViewController(identifier: "RateOfferVC") as! RateOfferVC
        rateOfferVC.offer = offer
        self.addChild(rateOfferVC)
        rateOfferVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview((rateOfferVC.view)!)
        rateOfferVC.didMove(toParent: self)
            
            self.view.addConstraints([
                NSLayoutConstraint(item: rateOfferVC.view!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: rateOfferVC.view!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: rateOfferVC.view!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: rateOfferVC.view!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
                ])
    }
    
    
}
