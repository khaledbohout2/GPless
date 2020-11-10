//
//  CategorySearchResultsVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/8/20.
//

import UIKit

class CategorySearchResultsVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var collectionViewContainerView: UIView!
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpTableView()
        
        
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.0)
        mainView.backgroundColor = UIColor(white: 1, alpha: 0.0)
            self.navigationController?.navigationBar.isHidden = true
            
            let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismisSearch))
            self.mainView.addGestureRecognizer(dismissGesture)
        
      //  self.searchView.backgroundColor = UIColor(white: 1, alpha: 1.0)



        // Do any additional setup after loading the view.
    }
    
    @objc func dismisSearch() {
        
        self.view.removeFromSuperview()
        
        
    }
    
    func setUpTableView() {
        
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        let nib = UINib(nibName: "CategoriesTableViewCell", bundle: nil)
        searchResultsTableView.register(nib, forCellReuseIdentifier: "CategoriesTableViewCell")
    }

}

extension CategorySearchResultsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
        cell.index = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
    
    
    
}
