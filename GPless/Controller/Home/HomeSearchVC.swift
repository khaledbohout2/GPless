//
//  HomeSearchVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/3/20.
//

import UIKit

class HomeSearchVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var notFoundImage: UIImageView!
    @IBOutlet weak var notFoundLbl: UILabel!
    @IBOutlet weak var noResultLbl: UILabel!
    
    var imageLink: String?
    
    var vendorID: String?
    var categoryType: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        localize()
        
        searchBar.delegate = self
    
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismisSearch))
        self.mainView.addGestureRecognizer(dismissGesture)

    }
    
    func setUpUI() {
        
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.0)
        mainView.backgroundColor = UIColor(white: 1, alpha: 0.0)
        self.navigationController?.navigationBar.isHidden = true
        makeBottomCornerRadius(myView: searchView)
        searchBar.layer.borderColor = searchBar.barTintColor?.cgColor
        
    }
    
    func localize() {
        
        notFoundLbl.text = "notfound".localizableString()
        notFoundLbl.setLocalization()
        noResultLbl.text = "thereisnoResult".localizableString()
        noResultLbl.setLocalization()
    }
    
    @objc func dismisSearch() {
        
        self.view.removeFromSuperview()
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    
    @IBAction func filterBtnTapped(_ sender: Any) {
        
        let storiBoard = UIStoryboard(name: "Home", bundle: nil)
        let filterVC = storiBoard.instantiateViewController(identifier: "FilterVC")
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    

}

extension HomeSearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            
            if Reachable.isConnectedToNetwork() {
            
            if vendorID != nil {
                
                searchOnVendorOffers(searchText: searchText)
            
            } else if categoryType != nil {
                
                searchOnCategoryOffers(searchText: searchText)
            } else {
                
                search(searchText: searchText)
            }
        }
            
        } else {
            
            notFoundImage.isHidden = true
            notFoundLbl.isHidden = true
            noResultLbl.isHidden = true
            self.view.backgroundColor = UIColor(white: 1, alpha: 0.0)
            mainView.backgroundColor = UIColor(white: 1, alpha: 0.0)
            searchView.backgroundColor = UIColor(white: 1, alpha: 1.0)

            
        }
    }
    
  
}

//MARK: - APIs

extension HomeSearchVC {
    
    func search(searchText: String){
    
    _ = Network.request(req: OfferSearchRequest(value: searchText)) { (result) in
        switch result {
        case .success(let offers):
            print(offers)
            if offers.offers?.count == 0 {
                
                self.notFoundImage.isHidden = false
                self.notFoundLbl.isHidden = false
                self.noResultLbl.isHidden = false
                
                self.view.backgroundColor = UIColor(white: 1, alpha: 1.0)
                self.searchView.backgroundColor = UIColor(white: 1, alpha: 1.0)
                
            } else {
                
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let homeSearchResultsVC =  storyboard.instantiateViewController(identifier: "HomeSearchResultsVC") as? HomeSearchResultsVC
                homeSearchResultsVC!.offersArr = offers.offers!
                self.addChild(homeSearchResultsVC!)
                homeSearchResultsVC?.view.frame = self.view.frame
                self.view.addSubview((homeSearchResultsVC?.view)!)
                homeSearchResultsVC?.didMove(toParent: self)
                
                self.notFoundImage.isHidden = true
                self.notFoundLbl.isHidden = true
                self.noResultLbl.isHidden = true
                
            }
        case .cancel(let cancelError):
            print(cancelError!)
            Toast.show(message: "Some error happened, Please try again later", controller: self)
        case .failure(let error):
            print(error!)
            Toast.show(message: "Some error happened, Please try again later", controller: self)
        }
      }
    
  }
    
    func searchOnVendorOffers(searchText: String) {

        
        _ = Network.request(req: searchOnBrandOffersRequest(id: vendorID! ,searchText: searchText)) { (result) in
            switch result {
            case .success(let offers):
                print(offers)
                if offers.offers?.count == 0 {
                    
                    self.notFoundImage.isHidden = false
                    self.notFoundLbl.isHidden = false
                    self.noResultLbl.isHidden = false
                    
                    self.view.backgroundColor = UIColor(white: 1, alpha: 1.0)
                    self.searchView.backgroundColor = UIColor(white: 1, alpha: 1.0)
                    
                } else {
                    
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let homeSearchResultsVC =  storyboard.instantiateViewController(identifier: "HomeSearchResultsVC") as? HomeSearchResultsVC
                    homeSearchResultsVC!.offersArr = offers.offers!
                    self.addChild(homeSearchResultsVC!)
                    homeSearchResultsVC?.view.frame = self.view.frame
                    self.view.addSubview((homeSearchResultsVC?.view)!)
                    homeSearchResultsVC?.didMove(toParent: self)
                    
                    self.notFoundImage.isHidden = true
                    self.notFoundLbl.isHidden = true
                    self.noResultLbl.isHidden = true
                    
                }
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        }
        }
    
    func searchOnCategoryOffers(searchText: String) {

        
        _ = Network.request(req: CategoryOffersSearchRequest(value: searchText, categoryType: self.categoryType!), completionHandler: { (result) in
            switch result {
            case .success(let offers):
                print(offers)
                if offers.offers?.count == 0 {
                    
                    self.notFoundImage.isHidden = false
                    self.notFoundLbl.isHidden = false
                    self.noResultLbl.isHidden = false
                    
                    self.view.backgroundColor = UIColor(white: 1, alpha: 1.0)
                    self.searchView.backgroundColor = UIColor(white: 1, alpha: 1.0)
                    
                } else {
                    
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let homeSearchResultsVC =  storyboard.instantiateViewController(identifier: "HomeSearchResultsVC") as? HomeSearchResultsVC
                    homeSearchResultsVC!.offersArr = offers.offers!
                    self.addChild(homeSearchResultsVC!)
                    homeSearchResultsVC?.view.frame = self.view.frame
                    self.view.addSubview((homeSearchResultsVC?.view)!)
                    homeSearchResultsVC?.didMove(toParent: self)
                    
                    self.notFoundImage.isHidden = true
                    self.notFoundLbl.isHidden = true
                    self.noResultLbl.isHidden = true
                    
                }
                
            case .cancel(let cancelError):
                print(cancelError!)
                Toast.show(message: "Sorry, some error happened, please try agian later.", controller: self)
            case .failure(let error):
                print(error!)
            }
        })
            
}
}
