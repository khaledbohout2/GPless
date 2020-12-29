//
//  FavouriteVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/17/20.
//

import UIKit

class FavouriteVC: UIViewController {

    @IBOutlet weak var favouriteTableView: UITableView!
    
    var favouriteOffers = [OfferModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        setUpNavigation()
        
        if Reachable.isConnectedToNetwork() {
            
        getFavouriteOffers()
            
        } else {
            
            Toast.show(message: "noInternet".localizableString(), controller: self)
        }
    }
    func initTableView() {
        
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
        let nib = UINib(nibName: "FavouriteTableViewCell", bundle: nil)
        favouriteTableView.register(nib, forCellReuseIdentifier: "FavouriteTableViewCell")
    }
    
    
    func setUpNavigation() {
        

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.title = "favouriteVC".localizableString()
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
    
}
extension FavouriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell", for: indexPath) as! FavouriteTableViewCell
        cell.configureCell(offer: favouriteOffers[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let offerDetailsVC = storyBoard.instantiateViewController(identifier: "OfferDetailsVC") as! OfferDetailsVC
        offerDetailsVC.id = "\(favouriteOffers[indexPath.row].id!)"
        self.navigationController?.pushViewController(offerDetailsVC, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
 
}

extension FavouriteVC {
    
    func getFavouriteOffers() {
        
        _ = Network.request(req: GetUserFavouritesRequest(), completionHandler: { (result) in
            switch result {
            case .success(let favouriteOffers):
                print(favouriteOffers)
                self.favouriteOffers = favouriteOffers
                self.favouriteTableView.reloadData()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })

    }
}
