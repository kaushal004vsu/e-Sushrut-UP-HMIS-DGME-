//
//  TokenGenerationViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 15/08/22.
//

import UIKit
import AVFoundation

class TokenGenerationViewController: UIViewController ,AVCaptureMetadataOutputObjectsDelegate,URLSessionDelegate{
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  view.backgroundColor = .systemBackground
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
        previewLayer.frame = view.layer.bounds
//        previewLayer.videoGravity = .resizeAspectFill  //for full screen scanner
        
        
        
        
       
       
        view.layer.addSublayer(previewLayer)
        self.view.bringSubviewToFront(lblTitle)
       // self.view.sendSubviewToBack(metadataOutput)
        createScanningFrame()
        createScanningIndicator()
        
        captureSession.startRunning()
        
       
      
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
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

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

        dismiss(animated: true)
    }

    func found(code: String) {
        print(code)
        
        if code.lowercased().range(of:"key") != nil {
            print("exists")
            
            let json =  JSON(parseJSON:code)
            var tokenQty = "1"

            let key=json["key"].stringValue;
            let arKey=key.components(separatedBy: "$")
            let counterId=arKey[0]
            let hospCode = counterId.substring(toIndex: 5)
//            let serviceId = counterId.substring(fromIndex: 5).substring(toIndex: 7)
            let serviceId="63"
            let isGender=arKey[1]
            let isSeniorCitizen = arKey[2];
            let isFamily:String=arKey[3];
            if(!(isFamily=="0"))
            {
                tokenQty = "4";
            }
            print("counterId : \(counterId) hospCode: \(hospCode) serviceId: \(serviceId) isGender: \(isGender) isSeniorCitizen: \(isSeniorCitizen) isFamily: \(isFamily)")
            
            let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
           
            let crno=obj!.crno
            let url:String = ServiceUrl.ip + "HQMS/services/restful/QmsServiceMobile/generateToken?crno=" + crno + "&hospCode=" + hospCode + "&counterId=" + counterId + "&serviceId=" + serviceId + "&isGender=" + isGender + "&isFamily=" + isFamily + "&isSeniorCtz=" + isSeniorCitizen + "&familyCount=" + tokenQty
print(url)
            callStampingService(data: url)
        }else{
            showAlert(title: "Invalid QR Code.", message: "Please scan a valid QR code.");
        }
        
    }

    
    
    func callStampingService(data:String)
    {
        let url = URL(string: data)
       
        var request = URLRequest(url: url!)
      //  request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        
       
        
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        
    urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                
                print("data \(data)")
                let status = json["status"].stringValue
                print("status :::: \(status)")
                
                if status=="1"
                {
                    let message=json["data"][0]["MSG"].stringValue
                    DispatchQueue.main.async {
                    self.showAlert(title:"Token Generation", message: message);
                    }
                }
                else{
                    //let stringData=String(data: data, encoding: String.Encoding.utf8) as String?
                   // let json = JSON.init(parseJSON: stringData!)
                    DispatchQueue.main.async {
                        let message = "Sorry! unable to generate token.";

                    self.showAlert(title:"Token Generation", message:  message);
                    }
                    
                }
               
                
                
            }catch{
                print("error"+error.localizedDescription)
                DispatchQueue.main.async {
                    let message = "Sorry! unable to generate token.";

                self.showAlert(title:"Token Generation", message:  message);
                }
            }
            }.resume()
    }
    
    
    
    
    
    
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func createScanningIndicator() {
        
        let height: CGFloat = 10
        let opacity: Float = 0.5
        //let topColor = UIColor.blue.withAlphaComponent(0)
        let topColor = UIColor.blue
        let bottomColor = UIColor.systemBlue

        let layer = CAGradientLayer()
        layer.colors = [topColor.cgColor, bottomColor.cgColor]
        layer.opacity = opacity
        
        let squareWidth = view.frame.width * 0.6
        let xOffset = view.frame.width * 0.2
        let yOffset = view.frame.midY - (squareWidth / 2)
        layer.frame = CGRect(x: xOffset, y: yOffset, width: squareWidth, height: height)
        
        self.view.layer.insertSublayer(layer, at: 1)

        let initialYPosition = layer.position.y
        let finalYPosition = initialYPosition + squareWidth - height
        let duration: CFTimeInterval = 3

        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = initialYPosition as NSNumber
        animation.toValue = finalYPosition as NSNumber
        animation.duration = duration
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        
        layer.add(animation, forKey: nil)
    }
    
    func createScanningFrame() {
                
        let lineLength: CGFloat = 40
        let squareWidth = view.frame.width * 0.6
        let topLeftPosX = view.frame.width * 0.2
        let topLeftPosY = view.frame.midY - (squareWidth / 2)
        let btmLeftPosY = view.frame.midY + (squareWidth / 2)
        let btmRightPosX = view.frame.midX + (squareWidth / 2)
        let topRightPosX = view.frame.width * 0.8
        
        let path = UIBezierPath()
        
        //top left
        path.move(to: CGPoint(x: topLeftPosX, y: topLeftPosY + lineLength))
        path.addLine(to: CGPoint(x: topLeftPosX, y: topLeftPosY))
        path.addLine(to: CGPoint(x: topLeftPosX + lineLength, y: topLeftPosY))

        //bottom left
        path.move(to: CGPoint(x: topLeftPosX, y: btmLeftPosY - lineLength))
        path.addLine(to: CGPoint(x: topLeftPosX, y: btmLeftPosY))
        path.addLine(to: CGPoint(x: topLeftPosX + lineLength, y: btmLeftPosY))

        //bottom right
        path.move(to: CGPoint(x: btmRightPosX - lineLength, y: btmLeftPosY))
        path.addLine(to: CGPoint(x: btmRightPosX, y: btmLeftPosY))
        path.addLine(to: CGPoint(x: btmRightPosX, y: btmLeftPosY - lineLength))

        //top right
        path.move(to: CGPoint(x: topRightPosX, y: topLeftPosY + lineLength))
        path.addLine(to: CGPoint(x: topRightPosX, y: topLeftPosY))
        path.addLine(to: CGPoint(x: topRightPosX - lineLength, y: topLeftPosY))
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.systemBlue.cgColor
        shape.lineWidth = 8
        shape.fillColor = UIColor.clear.cgColor
        
       
        self.view.layer.insertSublayer(shape, at: 1)
    }
    
    func showAlert(title:String,message:String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
                //                print("Handle Ok logic here")
                self.navigationController?.popToRootViewController(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        
    }
}
