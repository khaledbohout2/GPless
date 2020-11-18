//
//  RankVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/16/20.
//

import UIKit

class RankVC: UIViewController {
    
    @IBOutlet weak var rankTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        setUpNavigation()

    }
    
    func initTableView() {
        rankTableView.delegate = self
        rankTableView.dataSource = self
        let nib = UINib(nibName: "RankTableViewCell", bundle: nil)
        rankTableView.register(nib, forCellReuseIdentifier: "RankTableViewCell")
    }
    
    
    func setUpNavigation() {
        

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        
        self.title = "Rank"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
      //  search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        

        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    

    

}

extension RankVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankTableViewCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let moneySavedVC = storyBoard.instantiateViewController(identifier: "MoneySavedVC")
        self.navigationController?.pushViewController(moneySavedVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
}
