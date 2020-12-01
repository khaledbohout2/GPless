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
    
    var offersHistory = [OffersHistoryOffer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        setUpNavigation()
        getMoneySaved()
        getOffersHistory()

        // Do any additional setup after loading the view.
    }
    
    func initTableView() {
        
        offersHistoryTableView.delegate = self
        offersHistoryTableView.dataSource = self
        let nib = UINib(nibName: "OffersHistoryTableViewCells", bundle: nil)
        offersHistoryTableView.register(nib, forCellReuseIdentifier: "OffersHistoryTableViewCells")
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")

        self.title = "Money Saved"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
      //  search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
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
        
        label.font = UIFont(name: "Segoe UI-Regular", size: 12)

        return label

    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        var label : UILabel = UILabel()
//
//            label.text = offersHistory[section].date
//        label.textColor = hexStringToUIColor(hex: "#939393")
//
//        return label
//    }
        

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersHistory[section].offers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = tableView.indexPathsForVisibleRows?.first?.section
        let cell = tableView.dequeueReusableCell(withIdentifier: "OffersHistoryTableViewCells", for: indexPath) as! OffersHistoryTableViewCells
        let offer = offersHistory[index!].offers![indexPath.row]
        cell.configureCell(offer: offer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let favouriteVC = storyBoard.instantiateViewController(identifier: "FavouriteVC")
        self.navigationController?.pushViewController(favouriteVC, animated: true)

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
}
