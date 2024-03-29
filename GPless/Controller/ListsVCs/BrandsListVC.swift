//
//  BrandsListVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/9/20.
//
import UIKit
import CollectionViewPagingLayout


class BrandsListVC: UIViewController {
    
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var BrandsColectionView: UICollectionView!
    @IBOutlet weak var feutureBrandsLbl: UILabel!
    @IBOutlet weak var allBrandsLbl: UILabel!
    
    var scrollTimer: Timer?
    var index = 0
    
    let layout = CollectionViewPagingLayout()
    
    
    var brands = [Brand]()
    var featuredBrands = [Brand]()
    var scrollIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
        
        initCollectionView()
        
        setUpNavigation()
        
        if Reachable.isConnectedToNetwork() {
            
        getBrands()
        getFeaturedBrands()
            
        } else {
            
            Toast.show(message: "noInternet".localizableString(), controller: self)
        }
    }
    
    func initCollectionView() {
        
        bannersCollectionView.delegate = self
        bannersCollectionView.dataSource = self
        let nib = UINib(nibName: "BannersCollectionViewCell", bundle: nil)
        bannersCollectionView.register(nib, forCellWithReuseIdentifier: "BannersCollectionViewCell")
        
        bannersCollectionView.collectionViewLayout = layout
        bannersCollectionView.isPagingEnabled = true
        
        BrandsColectionView.delegate = self
        BrandsColectionView.dataSource = self
        let brandsNib = UINib(nibName: "BrandsColectionViewCell", bundle: nil)
        BrandsColectionView.register(brandsNib, forCellWithReuseIdentifier: "BrandsColectionViewCell")

    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

        self.title = "brands".localizableString()
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
    
    func localize() {

        feutureBrandsLbl.text = "featuredBrands".localizableString()
        feutureBrandsLbl.setLocalization()
        allBrandsLbl.text = "allBrands".localizableString()
        allBrandsLbl.setLocalization()
    }
    

    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func searchTapped() {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeSearchVC =  storyboard.instantiateViewController(identifier: "HomeSearchVC") as? HomeSearchVC
        self.addChild(homeSearchVC!)
        homeSearchVC?.view.frame = self.view.frame
        self.view.addSubview((homeSearchVC?.view)!)
        homeSearchVC?.didMove(toParent: self)
        
    }
    
    @objc func runTimedCode() {

        scrollIndex += 1

        if scrollIndex < featuredBrands.count - 1 {
            
            self.layout.goToNextPage()

        } else {
            
         //   self.layout.goToPreviousPage()
        }
        
        if scrollIndex == 3 {
            
            scrollTimer?.invalidate()
        }
    }

    deinit {

        scrollTimer?.invalidate()
    }
    
}
extension BrandsListVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == bannersCollectionView {
        
        return featuredBrands.count
            
        } else {
            
            return brands.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == bannersCollectionView {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannersCollectionViewCell", for: indexPath) as! BannersCollectionViewCell
        let photoLink = featuredBrands[indexPath.row].photoLink ?? ""
                        cell.bannerImageView.sd_setImage(with: URL(string: (SharedSettings.shared.settings?.usersPhotoLink ?? "") + "/" + photoLink))
        
        return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandsColectionViewCell", for: indexPath) as! BrandsColectionViewCell
            cell.configureCell(brand: brands[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == BrandsColectionView {
            
            let storyBoard = UIStoryboard(name: "Lists", bundle: nil)
            let paidOffersListVC = storyBoard.instantiateViewController(identifier: "PaidOffersListVC") as! PaidOffersListVC
            print(brands[indexPath.row].id!)
            paidOffersListVC.vendorId = "\(brands[indexPath.row].id!)"
            self.navigationController?.pushViewController(paidOffersListVC, animated: true)
        } else {
            
            let storyBoard = UIStoryboard(name: "Lists", bundle: nil)
            let paidOffersListVC = storyBoard.instantiateViewController(identifier: "PaidOffersListVC") as! PaidOffersListVC
            print(brands[indexPath.row].id!)
            paidOffersListVC.vendorId = "\(featuredBrands[indexPath.row].id!)"
            self.navigationController?.pushViewController(paidOffersListVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == bannersCollectionView {

            return layout.collectionViewContentSize
        

        } else {

            return CGSize(width: self.BrandsColectionView.frame.width / 2, height: self.BrandsColectionView.frame.width / 2)
        }
    }
    
}

extension BrandsListVC {
    
    func getBrands() {
        
        _ = Network.request(req: BrandsRequest(index: "\(self.index)", featured: false), completionHandler: { (result) in
            switch result {
            case .success(let response):
                print(response)
                self.brands = response.brands!
                
                DispatchQueue.main.async {
                    
                    self.BrandsColectionView.reloadData()
                }

            case .cancel(let cancelError):
            print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
    
    func getFeaturedBrands() {
        
        _ = Network.request(req: BrandsRequest(index: "\(self.index)", featured: true), completionHandler: { (result) in
            switch result {
            case .success(let response):
                
                print(response)
                
                self.featuredBrands = response.brands!
                self.bannersCollectionView.reloadData()
                self.scrollTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: true)
                
            case .cancel(let cancelError):
            print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
    
}
