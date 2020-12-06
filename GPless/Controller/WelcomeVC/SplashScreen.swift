//
//  SplashScreen.swift
//  GPless
//
//  Created by Khaled Bohout on 11/29/20.
//

import UIKit
import AVFoundation
import AVKit

class SplashScreen: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        getSettings()
   //    setupAVPlayer()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
        self.navigationController?.pushViewController(vc, animated: true)
         
    }
    

    func setupAVPlayer() {

        let videoURL = Bundle.main.url(forResource: "GPless 2 ffffff", withExtension: "mov") // Get video url
        let avAssets = AVAsset(url: videoURL!) // Create assets to get duration of video.
        let avPlayer = AVPlayer(url: videoURL!)// Create avPlayer instance
        let avpCntroller = AVPlayerViewController()
        avpCntroller.player = avPlayer // Create avPlayerLayer instance
                
        avpCntroller.view.frame.size.height = logoImageView.frame.size.height

        avpCntroller.view.frame.size.width = logoImageView.frame.size.width
        
        self.addChild(avpCntroller)

        logoImageView.addSubview(avpCntroller.view)
        
        avpCntroller.showsPlaybackControls = false
            
        avPlayer.play() // Play video

        // Add observer for every second to check video completed or not,
        // If video play is completed then redirect to desire view controller.
        avPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1) , queue: .main) { [weak self] time in

            if time == avAssets.duration {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
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