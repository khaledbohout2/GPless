//
//  CategoriesListVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class CategoriesListVC: UIViewController {
    
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        setUpNavigation()

        // Do any additional setup after loading the view.
    }
    
    func initTableView() {
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        let nib = UINib(nibName: "CategoriesTableViewCell", bundle: nil)
        categoriesTableView.register(nib, forCellReuseIdentifier: "CategoriesTableViewCell")
    }
    
    func setUpNavigation() {
        

        self.title = "Categories"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let search = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchTapped))
        search.image = UIImage(named: "navigationSearch")
        search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.rightBarButtonItem = search
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
      //  search.tintColor = hexStringToUIColor(hex: "")
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
        cell.delegate = self
        cell.index = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
    
    
    
}

extension CategoriesListVC: VerticalCellDelegate {
    
    func navigateToListVC() {
        let storyBoard = UIStoryboard(name: "Lists", bundle: nil)
        let foodOffersListVC = storyBoard.instantiateViewController(identifier: "FoodOffersListVC")
        self.navigationController?.pushViewController(foodOffersListVC, animated: true)
    }
    
    
}
