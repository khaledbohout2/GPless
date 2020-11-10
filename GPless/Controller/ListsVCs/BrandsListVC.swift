//
//  BrandsListVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/9/20.
//

class BrandsListVC: UIViewController {
    
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    
    @IBOutlet weak var BrandsColectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
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
        
    }
    
}
extension BrandsListVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == bannersCollectionView {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannersCollectionViewCell", for: indexPath)
        
        return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandsColectionViewCell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == bannersCollectionView {
        
        return CGSize(width: (self.bannersCollectionView.frame.width), height: (self.bannersCollectionView.frame.height
        ))
            
        } else {
            
            return CGSize(width: self.BrandsColectionView.frame.width / 2, height: self.BrandsColectionView.frame.width / 2)
        }
    }
    
}


