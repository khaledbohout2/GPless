//
//  EnterBranchID.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit
import AVFoundation

class EnterBranchIDVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var QRreaderView: UIView!
    @IBOutlet weak var enterBranchIdLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var ids: [Int]?
    var vendorCode: String?
    var selectedBranch: Branch!
    var offer: OfferModel?
    var keyBoardHeight: CGFloat?
    var height: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        
        makeBottomCornerRadius(myView: mainView)
        startReadingQR()
        
        // Do any additional setup after loading the view.
    }
    
    func localize() {
        enterBranchIdLbl.text = "enterBranchID".localizableString()
        cancelBtn.setTitle("cancel".localizableString(), for: .normal)
    }
    
    
    func setUpNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!, NSAttributedString.Key.foregroundColor:hexStringToUIColor(hex: "#282828")]
        
        navigationController?.navigationBar.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: "#FFFFFF")

        self.title = "Food Offers"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backTapped))
        back.image = UIImage(named: "ArrowLeft")
      // search.tintColor = hexStringToUIColor(hex: "")
        navigationItem.leftBarButtonItem = back
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    
    func startReadingQR() {
        
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = QRreaderView.layer.frame
        previewLayer.frame.size.height = QRreaderView.frame.size.height
        previewLayer.frame.size.width = QRreaderView.frame.size.width
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }
    
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            found(code: stringValue)
        }

    }

    func found(code: String) {
        
        
        
        let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
        let checkOutFromBranchVC = storyBoard.instantiateViewController(identifier: "CheckOutFromBranchVC") as! CheckOutFromBranchVC
            checkOutFromBranchVC.vendorCode = code
        checkOutFromBranchVC.selectedBranch = self.selectedBranch
        if getUserType() == "0" {
            checkOutFromBranchVC.ids = self.ids
        } else {
            checkOutFromBranchVC.offer = self.offer
        }
        self.navigationController?.pushViewController(checkOutFromBranchVC, animated: true)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

}

//extension EnterBranchIDVC {
//
//
//    func confirmOffer() {
//
//        print(self.ids!)
//        print(self.vendorCode!)
//
//        let confirmOffer = ConfirmOffer(ids: self.ids!, branchCode: "\(self.vendorCode!)")
//        var par = [String: Any]()
//
//
//        do {
//            let jsonData = try JSONEncoder().encode(confirmOffer)
//            let jsonString = String(data: jsonData, encoding: .utf8)!
//            print(jsonString)
//
//            let decodedConfirmOffer = try JSONDecoder().decode(ConfirmOffer.self, from: jsonData)
//
//            print(decodedConfirmOffer)
//
//            let decoded = try! decodedConfirmOffer.asDictionary()
//
//            print(decoded)
//
//            par = ["ids": decodedConfirmOffer.ids!, "branch_code" : decodedConfirmOffer.branchCode!] as [String : Any]
//
//
//
//        } catch { print(error) }
//
//        _ = Network.request(req: ConfirmOfferRequest(confirmOffer: par) , completionHandler: { (result) in
//            switch result {
//            case .success(let response):
//
//                if response.error == nil {
//                    print(response)
//                    let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
//                    let paymentSuccesfullBranch = storyBoard.instantiateViewController(identifier: "paymentSuccesfullBranch")
//                    self.navigationController?.pushViewController(paymentSuccesfullBranch, animated: true)
//                } else {
//
//                    print(response.error!)
//
//                    let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
//                    let paymentErrorVC = storyBoard.instantiateViewController(identifier: "PaymentErrorVC")
//                    self.navigationController?.pushViewController(paymentErrorVC, animated: true)
//                }
//
//            case .cancel(let cancelError):
//                print(cancelError!)
//                let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
//                let paymentErrorVC = storyBoard.instantiateViewController(identifier: "PaymentErrorVC")
//                self.navigationController?.pushViewController(paymentErrorVC, animated: true)
//            case .failure(let error):
//                print(error!)
//                let storyBoard = UIStoryboard(name: "Offer", bundle: nil)
//                let paymentErrorVC = storyBoard.instantiateViewController(identifier: "PaymentErrorVC")
//                self.navigationController?.pushViewController(paymentErrorVC, animated: true)
//            }
//        })
//    }
//}
