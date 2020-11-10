//
//  GetOfferVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit

class OfferDetailsVC: UIViewController {
    
    @IBOutlet weak var brandView: UIView!
    
    @IBOutlet weak var brnadViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var stroesTableView: UITableView!
    
    
    @IBOutlet weak var brandImageView: UIImageView!
    
    var isAreasExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()

        // Do any additional setup after loading the view.
    }
    

    func setUp() {
        
        let openStoresGesture = UIGestureRecognizer(target: self, action: #selector(self.openStores))
        
        brandView.addGestureRecognizer(openStoresGesture)
        brandImageView.addGestureRecognizer(openStoresGesture)
        
        stroesTableView.delegate = self
        stroesTableView.dataSource = self
        
        // ExpandableTableViewCell
        
        let nib = UINib(nibName: "ExpandableTableViewCell", bundle: nil)
        
        stroesTableView.register(nib, forCellReuseIdentifier: "ExpandableTableViewCell")
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func openStores (_ sender: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            if !self.isAreasExpanded {
             self.brnadViewHeight?.constant = 279
                self.isAreasExpanded = true
            } else {
                self.brnadViewHeight?.constant = 94
                self.isAreasExpanded = false
            }
             self.view.layoutIfNeeded()
         }, completion: nil)
        
    }
    
    @IBAction func expandStoresGesture(_ sender: Any) {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            if !self.isAreasExpanded {
             self.brnadViewHeight?.constant = 279
                self.isAreasExpanded = true
            } else {
                self.brnadViewHeight?.constant = 94
                self.isAreasExpanded = false
            }
             self.view.layoutIfNeeded()
         }, completion: nil)
    }
    
    
    
    @IBAction func getOfferBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let cartVC = storyBoard.instantiateViewController(identifier: "CartVC")
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
}
extension OfferDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell")
        return cell!
    }

    
    
    
}
