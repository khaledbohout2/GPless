//
//  CategoriesListVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class CategoriesListVC: UIViewController {
    
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    var categories = [CategoryElement]()
    var index = 1
    var startCount = 0
    var endCount = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        setUpNavigation()
        
        if Reachable.isConnectedToNetwork() {
            
        getCategories()
            
        } else {
            
            Toast.show(message: "noInternet", controller: self)
        }

    }
    
    func initTableView() {
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        let nib = UINib(nibName: "CategoriesTableViewCell", bundle: nil)
        categoriesTableView.register(nib, forCellReuseIdentifier: "CategoriesTableViewCell")
    }
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular".localizableString(), size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]

        navigationController?.navigationBar.clipsToBounds = true
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        self.title = "categories".localizableString()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let search = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchTapped))
        search.image = UIImage(named: "navigationSearch")
        search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.rightBarButtonItem = search
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft".localizableString())
        back.tintColor = hexStringToUIColor(hex: "#000000")
        navigationItem.leftBarButtonItem = back
        
    }
    
    @objc func searchTapped() {
        
        let storyboard = UIStoryboard(name: "Lists", bundle: nil)
        let homeSearchVC =  storyboard.instantiateViewController(identifier: "CategorySearchVC") as? CategorySearchVC
        self.addChild(homeSearchVC!)
        homeSearchVC?.view.frame = self.view.frame
        self.view.addSubview((homeSearchVC?.view)!)
        homeSearchVC?.didMove(toParent: self)
        
        
        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension CategoriesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categories.count % 3 == 0 {
            
            return categories.count / 3
            
        } else {
            
            return (categories.count / 3) + 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
        cell.delegate = self
        cell.index = indexPath.row
        
        var cellCategories = [CategoryElement]()
        
        if endCount > categories.count - 1 {
            endCount = categories.count - 1
            if startCount > endCount {
                startCount = endCount
            }
        }
        
        for index in startCount...endCount {
            
            let category = categories[index]
            cellCategories.append(category)
        }
        
        print(cellCategories.count)
        
        startCount += 3
        endCount += 3
        
        cell.configureCell(categories: cellCategories)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.width / 1.75
        
    }
    
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           
                if indexPath.row == (self.categories.count / 3) - 1 {
                    index += 1
                    getCategories()
                    
                }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Lists", bundle: nil)
        let offersListVC = storyBoard.instantiateViewController(identifier: "OffersListVC") as! OffersListVC
        self.navigationController?.pushViewController(offersListVC, animated: true)
    }
}

extension CategoriesListVC: VerticalCellDelegate {
    
    func navigateToListVC(category: CategoryElement) {
        let storyBoard = UIStoryboard(name: "Lists", bundle: nil)
        let offersListVC = storyBoard.instantiateViewController(identifier: "OffersListVC") as! OffersListVC
        offersListVC.categoryType = category.categoryName
        self.navigationController?.pushViewController(offersListVC, animated: true)
    }
    
}

//MARK: - APIs

extension CategoriesListVC {
    
    func getCategories() {
        
        _ = Network.request(req: CategoriesRequest(index: "\(self.index)"), completionHandler: { (result) in
           switch result {
           case .success(let response):
           print(response)
            if self.index == 1 {
            self.categories = response.categories!
            } else {
                for cat in response.categories! {
                    self.categories.append(cat)
                }
            }
            self.startCount = 0
            self.endCount = 2
            self.categoriesTableView.reloadData()
           case .cancel(let cancelError):
           print(cancelError!)
           case .failure(let error):
           print(error!)
            }
        })
    }
}
