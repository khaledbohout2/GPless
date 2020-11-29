//
//  BrandsListVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/9/20.
//
import Gemini

class BrandsListVC: UIViewController {
    
    @IBOutlet weak var bannersCollectionView: GeminiCollectionView!
    
    @IBOutlet weak var BrandsColectionView: UICollectionView!
    
    let photos = ["1", "2", "3"]
    
    var brands = [Brand]()
    
    var index = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        getBrands()
    }
    
    func initCollectionView() {
        
        bannersCollectionView.delegate = self
        bannersCollectionView.dataSource = self
        let nib = UINib(nibName: "BannersCollectionViewCell", bundle: nil)
        bannersCollectionView.register(nib, forCellWithReuseIdentifier: "BannersCollectionViewCell")
        
        BrandsColectionView.delegate = self
        BrandsColectionView.dataSource = self
        let brandsNib = UINib(nibName: "BrandsColectionViewCell", bundle: nil)
        BrandsColectionView.register(brandsNib, forCellWithReuseIdentifier: "BrandsColectionViewCell")
        
        bannersCollectionView.gemini
            .customAnimation()
            .translation(x: 0, y: 50, z: 0)
            .rotationAngle(x: 0, y: 13, z: 0)
            .ease(.easeOutExpo)
            .shadowEffect(.fadeIn)
            .maxShadowAlpha(0.3)
        
        
    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        

        self.title = "Brands"
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
        self.addChild(homeSearchVC!)
        homeSearchVC?.view.frame = self.view.frame
        self.view.addSubview((homeSearchVC?.view)!)
        homeSearchVC?.didMove(toParent: self)
        
    }
    
}
extension BrandsListVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == bannersCollectionView {
        
        return photos.count
            
        } else {
            
            return brands.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == bannersCollectionView {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannersCollectionViewCell", for: indexPath) as! BannersCollectionViewCell
            cell.bannerImageView.image = UIImage(named: photos[indexPath.row])
            // Animate
            self.bannersCollectionView.animateCell(cell)
        
        return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandsColectionViewCell", for: indexPath) as! BrandsColectionViewCell
            cell.configureCell(brand: brands[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == bannersCollectionView {
        
        return CGSize(width: (self.bannersCollectionView.frame.width - 114), height: (self.bannersCollectionView.frame.height
        ))
            
        } else {
            
            return CGSize(width: self.BrandsColectionView.frame.width / 2, height: self.BrandsColectionView.frame.width / 2)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Animate
        self.bannersCollectionView.animateVisibleCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // Animate
        if let cell = cell as? BannersCollectionViewCell {
            self.bannersCollectionView.animateCell(cell)
        }
        
    }
    
}

extension BrandsListVC {
    
    func getBrands() {
        
        _ = Network.request(req: BrandsRequest(index: "\(self.index)"), completionHandler: { (result) in
            switch result {
            case .success(let response):
                print(response)
                self.brands = response.brands!
                self.bannersCollectionView.reloadData()
                self.BrandsColectionView.reloadData()
            case .cancel(let cancelError):
            print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
    
}


