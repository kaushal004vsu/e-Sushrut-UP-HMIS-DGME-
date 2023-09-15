//
//  QRCodeViewController.swift
//  AIIMS Raipur Swasthya
//
//  Created by sudeep rai on 20/12/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblCRNo: UILabel!
    @IBOutlet weak var imgQRCode: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        
        let name:String=obj!.firstName
        let age:String=obj!.age
        let gender:String=obj!.gender
        let crno:String=obj!.crno
        
//        let crno:String="3320122100250";
        lblName.text=name+" ("+age+"/"+gender+")";
//        lblName.text="Sudeep(25 Yr/M)"
        
        lblCRNo.text="CRN.: "+crno;
//        let barcodeContents = "{\"name\":  \"\(name)\",\"age\":\"\(age)\",\"Gender\":\"\(gender)\",\"crno\": \"\(crno)\",\"hospCode\":\"\(ServiceUrl.hospCode)\"}";
        
        let barcodeContents:String=obj!.crno;
        let image = generateQRCode(from: barcodeContents)
   
        imgQRCode.image=image;
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
  /*  @IBAction func btnHome(_ sender: Any) {
        DispatchQueue.main.async {
        var rootVC : UIViewController?
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PatientNavigationController") as! UINavigationController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
              appDelegate.window?.rootViewController = rootVC
            
        }
    }*/
    

}
