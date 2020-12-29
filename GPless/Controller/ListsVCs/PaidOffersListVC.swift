//
//  PaidOffersListVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class PaidOffersListVC: UIViewController {
    
    
    @IBOutlet weak var paidOffersCollectionView: UICollectionView!
    
    var gridView = true
    var type: String?
    var index = 1
    var offersArr = [OfferModel]()
    var vendorId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        setUpNavigation()
        
        if Reachable.isConnectedToNetwork() {
        
        if vendorId != nil {
            
            getVendorOffers()
            self.title = "Offers"
            
        } else {
            
            getPaidOffers()
        }
            
        } else {
            
            Toast.show(message: "noInternet".localizableString(), controller: self)
        }
        

    }
    
    func initCollectionView() {
        
        let paidOffersNib = UINib(nibName: "PaidOffersCollectionViewCell", bundle: nil)
        let paidOffersVerticalNib = UINib(nibName: "PaidOffersVerticalCollectionViewCell", bundle: nil)
        paidOffersCollectionView.register(paidOffersNib, forCellWithReuseIdentifier: "PaidOffersCollectionViewCell")
        paidOffersCollectionView.register(paidOffersVerticalNib, forCellWithReuseIdentifier: "PaidOffersVerticalCollectionViewCell")
        let hotOffersNib = UINib(nibName: "HotOffersCollectionViewCell", bundle: nil)
        
        paidOffersCollectionView.register(hotOffersNib, forCellWithReuseIdentifier: "HotOffersCollectionViewCell")
        paidOffersCollectionView.delegate = self
        paidOffersCollectionView.dataSource = self

    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

        self.title = "Paid Offers".localizableString()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft".localizableString())
        back.tintColor = hexStringToUIColor(hex: "#000000")
        navigationItem.leftBarButtonItem = back
        
        let search = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchTapped))
        search.image = UIImage(named: "navigationSearch")
        search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.rightBarButtonItem = search
        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func searchTapped() {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeSearchVC =  storyboard.instantiateViewController(identifier: "HomeSearchVC") as? HomeSearchVC
        if vendorId != nil {
            homeSearchVC!.vendorID = vendorId!
        } 
        self.addChild(homeSearchVC!)
        homeSearchVC?.view.frame = self.view.frame
        self.view.addSubview((homeSearchVC?.view)!)
        homeSearchVC?.didMove(toParent: self)
        
    }

    
    
    @IBAction func switchListingBtnTapped(_ sender: Any) {
        
        if gridView {
            
            if let flowLayout = paidOffersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .vertical
            }
            gridView = !gridView
            
        } else {
            
            if let flowLayout = paidOffersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
            }
            gridView = !gridView
            
        }
        paidOffersCollectionView.reloadData()
        
    }
    
    @IBAction func filterBtnTapped(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Home", bundle: nil)
        let filterVC = storiBoard.instantiateViewController(identifier: "FilterVC")
        self.navigationController?.pushViewController(filterVC, animated: true)
        
    }
    
    
}

extension PaidOffersListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return offersArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if gridView {
            
            if self.type == "paid" {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaidOffersCollectionViewCell", for: indexPath) as! PaidOffersCollectionViewCell
                cell.configureCell(offer: offersArr[indexPath.row])
        return cell
                
            } else {
                
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotOffersCollectionViewCell", for: indexPath) as! HotOffersCollectionViewCell
                cell.configureCell(offer: offersArr[indexPath.row])
                return cell
            }
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaidOffersVerticalCollectionViewCell", for: indexPath) as! PaidOffersVerticalCollectionViewCell
            cell.configureCell(offer: offersArr[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if gridView {
            
        return CGSize(width: collectionView.frame.width / 2, height: 162)
            
        } else {
            
            return CGSize(width: collectionView.frame.width, height: 116)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let offerDetailsVC = storyBoard.instantiateViewController(identifier: "OfferDetailsVC") as! OfferDetailsVC
        offerDetailsVC.id = "\(offersArr[indexPath.row].id!)"
        self.navigationController?.pushViewController(offerDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == self.offersArr.count - 1 {
            index += 1
            if vendorId != nil {
            getVendorOffers()
            } else {
            getPaidOffers()
            }
        }
    }
}

//MARK:- APIs

extension PaidOffersListVC {
    
    func getPaidOffers() {

        _ = Network.request(req: OffersRequest(index: "\(self.index)", type: self.type!), completionHandler: { (result) in
            
            switch result {
            case .success(let response):
                if self.index == 1 {
                    
                self.offersArr = response.offers!
                    
                } else {
                    
                    for offer in response.offers! {
                        
                        self.offersArr.append(offer)
                    }
                }
                
                self.paidOffersCollectionView.reloadData()
                
            case .cancel(let cancelError):
            print(cancelError!)
            case .failure(let error):
            print(error!)
            }
        })
    }
    
    func getVendorOffers() {
        
        
        _ = Network.request(req: VendorOffers(id: self.vendorId!), completionHandler: { (result) in
            switch result {
            case .success(let response):
                print(self.index)
                print(response)
                if self.index == 1 {
                self.offersArr = response.offers!
                    
                } else {
                    
                    for offer in response.offers! {
                        
                        self.offersArr.append(offer)
                    }
                }
                
                self.paidOffersCollectionView.reloadData()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
        
    }
}


