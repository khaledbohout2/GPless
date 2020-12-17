//
//  PointsVC.swift
//  GPless
//
//  Created by Khaled Bohout on 11/15/20.
//

import UIKit

class PointsVC: UIViewController {
    
    @IBOutlet weak var pointsTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var howItWorksLbl: UILabel!
    @IBOutlet weak var gettingRewardsLbl: UILabel!
    
    var pointsArr = [PointsResponseOffer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTopCornerRadius(myView: headerView)
        initTableView()
        localize()
        getPoints()

        // Do any additional setup after loading the view.
    }
    
    func localize() {
        
        howItWorksLbl.text = "howItWorks".localizableString()
        howItWorksLbl.setLocalization()
        gettingRewardsLbl.text = "GettingRewards".localizableString()
        gettingRewardsLbl.setLocalization()
    }
    
    func initTableView() {

        pointsTableView.delegate = self
        pointsTableView.dataSource = self
        let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        pointsTableView.register(nib, forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        navigationController?.navigationBar.clipsToBounds = true
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")
        self.title = "Points"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
     //   search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
        

        
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func FAQBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        let rankVC = storyBoard.instantiateViewController(identifier: "RankVC")
        self.navigationController?.pushViewController(rankVC, animated: true)
    }
    

}

extension PointsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.configureCell(points: pointsArr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
    
}

extension PointsVC {
    
    func getPoints() {
        _ = Network.request(req: GetUserPointsRequest(), completionHandler: { (result) in
            switch result {
            case .success(let points):
                print(points)
                self.pointsArr = points.offers!
                self.pointsTableView.reloadData()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
}
