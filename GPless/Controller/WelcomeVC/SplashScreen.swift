//
//  SplashScreen.swift
//  GPless
//
//  Created by Khaled Bohout on 11/29/20.
//

import UIKit
import AVFoundation
import AVKit
import Gifu

class SplashScreen: UIViewController {
    
    @IBOutlet weak var logoImageView: GIFImageView!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        setupAVPlayer()
        getSettings()
  
    }
    
    func setupAVPlayer() {
        
        logoImageView.animate(withGIFNamed: "GPless- logo gif")
        
        timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(pushVC), userInfo: nil, repeats: true)
    }
    
    @objc func pushVC() {
        
        let welcomeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
        self.navigationController?.pushViewController(welcomeVC, animated: true)
        timer.invalidate()
    }

}

extension SplashScreen {
    
    func getSettings() {
        
        _ = Network.request(req: SettingsRequet(index: "1"), completionHandler: { (result) in
            switch result {
            case .success(let settings):
                print(settings)
                SharedSettings.shared.settings = settings
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        })
    }
}
