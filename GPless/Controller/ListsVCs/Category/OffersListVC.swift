//
//  OffersListVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class OffersListVC: UIViewController {

    @IBOutlet weak var offersCollectionView: UICollectionView!
    
    var gridView = true
    var index = 1
    var categoryType: String?
    var offersArr = [OfferModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        
        if Reachable.isConnectedToNetwork() {
        
        if offersArr.count != 0 {
            
        } else {
            
        getCategoryOffers()
            
        }
        } else {
            Toast.show(message: "No Internet", controller: self)
        }
        
        setUpNavigation()

        // Do any additional setup after loading the view.
    }
    

    func setUpCollectionView() {

        
        let hotOffersNib = UINib(nibName: "HotOffersCollectionViewCell", bundle: nil)
        offersCollectionView.register(hotOffersNib, forCellWithReuseIdentifier: "HotOffersCollectionViewCell")
        
        let paidOffersNib = UINib(nibName: "PaidOffersCollectionViewCell", bundle: nil)
        offersCollectionView.register(paidOffersNib, forCellWithReuseIdentifier: "PaidOffersCollectionViewCell")
        
        let paidOffersVerticalNib = UINib(nibName: "PaidOffersVerticalCollectionViewCell", bundle: nil)
        offersCollectionView.register(paidOffersVerticalNib, forCellWithReuseIdentifier: "PaidOffersVerticalCollectionViewCell")
        
        offersCollectionView.delegate = self
        offersCollectionView.dataSource = self
    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

        self.title = categoryType
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
      //  search.tintColor = hexStringToUIColor(hex: "")
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
        homeSearchVC!.categoryType = categoryType
        self.addChild(homeSearchVC!)
        homeSearchVC?.view.frame = self.view.frame
        self.view.addSubview((homeSearchVC?.view)!)
        homeSearchVC?.didMove(toParent: self)
        
    }
    
    @IBAction func switchListingBtnTapped(_ sender: Any) {
        
        if gridView {
            
            if let flowLayout = offersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .vertical
            }
            gridView = !gridView
            
        } else {
            
            if let flowLayout = offersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
            }
            gridView = !gridView
            
        }
        offersCollectionView.reloadData()
        
    }
    
    
    @IBAction func filterBtnTapped(_ sender: Any) {
    }
    
}

extension OffersListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offersArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if gridView {
            
            if offersArr[indexPath.row].type == "paid" {
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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
    
    
    
    
}

extension OffersListVC {
    
    func getCategoryOffers() {
        
        _ = Network.request(req: CategoryOffersRequest(index: "\(self.index)", categoryType: self.categoryType!), completionHandler: { (result) in
            switch result {
            case .success(let offers):
                print(offers)
                self.offersArr = offers.offers!
                self.offersCollectionView.reloadData()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
}
